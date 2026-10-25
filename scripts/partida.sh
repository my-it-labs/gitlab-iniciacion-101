#!/usr/bin/env bash
# Prepara el punto de partida de una página: crea en GitLab, en el espacio de <usuario>,
# un proyecto con el manual del equipo y un historial inicial, y lo clona por SSH en el
# ordenador de esa persona (pc-<usuario>), en ~/trabajo/<proyecto>.
#
# Uso (en el terminal del Codespace): scripts/partida.sh <usuario> <proyecto> [opciones]
#   --con-ci            incluye .gitlab-ci.yml (validar + construir)
#   --solo-remoto       no clona en el ordenador de <usuario>
#   --miembro <otro>    añade a <otro> como Developer y clona también en su ordenador
#   --preparar <otro>   solo deja listo el ordenador de <otro> (identidad y clave), sin darle acceso
#
# Necesita el entorno levantado con infra/bootstrap.sh (lee infra/.env).
# Deja listo el ordenador de cada persona: si le falta la identidad de Git o la clave SSH
# (en el ordenador o en su perfil de GitLab), las configura.
set -euo pipefail

RAIZ="$(cd "$(dirname "$0")/.." && pwd)"
ORIGEN="$RAIZ/proyecto/manual-equipo"
ENV="$RAIZ/infra/.env"

[ $# -ge 2 ] || { sed -n '2,14p' "$0" | sed 's/^# \{0,1\}//'; exit 2; }
USUARIO="$1"; PROYECTO="$2"; shift 2
CON_CI=0; CLONAR=1; MIEMBRO=""; PREPARAR=""
while [ $# -gt 0 ]; do
  case "$1" in
    --con-ci) CON_CI=1 ;;
    --solo-remoto) CLONAR=0 ;;
    --miembro) MIEMBRO="${2:?Falta el usuario de --miembro}"; shift ;;
    --preparar) PREPARAR="${2:?Falta el usuario de --preparar}"; shift ;;
    *) echo "Opción desconocida: $1" >&2; exit 2 ;;
  esac
  shift
done

[ -f "$ENV" ] || { echo "No existe $ENV: levanta el entorno con infra/bootstrap.sh" >&2; exit 1; }
# shellcheck disable=SC1090
. "$ENV"

api() { curl -sS -f -H "PRIVATE-TOKEN: $GITLAB_TOKEN" "$@"; }
campo() { grep -o "\"$1\":\"\{0,1\}[^\",}]*" | head -n 1 | sed "s/.*[:\"]//"; }
en_pc() { local u="$1"; shift; docker exec -u "$u" -w "/home/$u" "pc-$u" "$@"; }

id_de() {
  local id
  id=$(api "$GITLAB_URL/api/v4/users?username=$1" | campo id)
  [ -n "$id" ] || { echo "No existe el usuario $1 en GitLab" >&2; exit 1; }
  echo "$id"
}

# Identidad de Git, clave SSH registrada y GitLab en known_hosts, en el ordenador de <u>.
preparar_pc() {
  local u="$1" id="$2" pc="pc-$1" datos nombre correo clave
  docker inspect "$pc" >/dev/null 2>&1 || { echo "No existe el ordenador $pc (¿infra/bootstrap.sh?)" >&2; exit 1; }
  if ! en_pc "$u" git config --global user.email >/dev/null; then
    datos=$(api "$GITLAB_URL/api/v4/users/$id")
    nombre=$(echo "$datos" | campo name); correo=$(echo "$datos" | campo email)
    en_pc "$u" git config --global user.name "$nombre"
    en_pc "$u" git config --global user.email "$correo"
    en_pc "$u" git config --global init.defaultBranch main
    echo "Identidad de Git configurada en $pc: $nombre <$correo>"
  fi
  en_pc "$u" mkdir -p trabajo
  en_pc "$u" mkdir -p -m 700 .ssh
  if ! en_pc "$u" test -f .ssh/id_ed25519.pub; then
    en_pc "$u" ssh-keygen -q -t ed25519 -N "" -C "$u@$pc" -f ".ssh/id_ed25519"
    echo "Clave SSH creada en $pc"
  fi
  clave=$(en_pc "$u" cat .ssh/id_ed25519.pub | cut -d' ' -f1,2)
  if ! api "$GITLAB_URL/api/v4/users/$id/keys" | grep -qF "${clave#* }"; then
    api -X POST "$GITLAB_URL/api/v4/users/$id/keys" --data-urlencode "title=$u@$pc" \
      --data-urlencode "key=$clave" >/dev/null
    echo "Clave SSH de $pc registrada en el perfil de $u"
  fi
  en_pc "$u" sh -c 'ssh-keygen -F gitlab >/dev/null 2>&1 || ssh-keyscan -t ed25519 gitlab >> .ssh/known_hosts 2>/dev/null'
}

clonar_en() {
  local u="$1" destino="trabajo/$PROYECTO"
  if en_pc "$u" test -e "$destino"; then
    echo "Ya existe ~/$destino en pc-$u: no se clona (bórralo o usa otro nombre)" >&2
    exit 1
  fi
  en_pc "$u" mkdir -p trabajo
  en_pc "$u" git clone -q "git@gitlab:$USUARIO/$PROYECTO.git" "$destino"
  echo "Copia local: ~/$destino en el ordenador de $u (pc-$u)"
}

ID_USUARIO=$(id_de "$USUARIO")
[ -z "$MIEMBRO" ] || ID_MIEMBRO=$(id_de "$MIEMBRO")
[ -z "$PREPARAR" ] || ID_PREPARAR=$(id_de "$PREPARAR")

# Ruta exacta: GitLab redirige el nombre de un proyecto borrado al renombrado (…-deletion_scheduled-N).
if [ "$(api "$GITLAB_URL/api/v4/projects/$USUARIO%2F$PROYECTO" 2>/dev/null | campo path_with_namespace)" = "$USUARIO/$PROYECTO" ]; then
  echo "Ya existe $USUARIO/$PROYECTO en GitLab. Usa otro nombre, p. ej. $PROYECTO-2" >&2
  exit 1
fi

echo "Creando $USUARIO/$PROYECTO en GitLab…"
api -X POST "$GITLAB_URL/api/v4/projects/user/$ID_USUARIO" -d "name=$PROYECTO" -d "path=$PROYECTO" \
  -d visibility=private -d initialize_with_readme=false >/dev/null

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
(
  cd "$TMP"
  git init -q -b main
  git config user.name "${GIT_AUTOR:-Equipo de documentación}"
  git config user.email "${GIT_CORREO:-documentacion@equipo.local}"
  cp "$ORIGEN/README.md" .
  git add README.md && git commit -q -m "Crea el manual del equipo"
  mkdir -p docs scripts
  cp "$ORIGEN/docs/bienvenida.md" "$ORIGEN/docs/herramientas.md" docs/
  git add docs && git commit -q -m "Añade bienvenida y herramientas"
  cp "$ORIGEN/docs/normas-de-trabajo.md" docs/
  cp "$ORIGEN/scripts/"*.sh scripts/
  git add docs scripts && git commit -q -m "Añade normas de trabajo y scripts de validación"
  if [ "$CON_CI" = 1 ]; then
    cp "$ORIGEN/.gitlab-ci.yml" .
    git add .gitlab-ci.yml && git commit -q -m "Añade pipeline de validación"
  fi
  HOST="${GITLAB_URL#*://}"; ESQUEMA="${GITLAB_URL%%://*}"
  git push -q "$ESQUEMA://root:$GITLAB_TOKEN@$HOST/$USUARIO/$PROYECTO.git" main 2>/dev/null
)
# El push lo hace root, que no lanza pipeline: se lanza el primero en nombre de <usuario>.
if [ "$CON_CI" = 1 ]; then
  api -X POST -H "Sudo: $USUARIO" "$GITLAB_URL/api/v4/projects/$USUARIO%2F$PROYECTO/pipeline?ref=main" >/dev/null
fi
echo "Proyecto: $GITLAB_URL/$USUARIO/$PROYECTO"

preparar_pc "$USUARIO" "$ID_USUARIO"
[ "$CLONAR" = 0 ] || clonar_en "$USUARIO"

if [ -n "$MIEMBRO" ]; then
  api -X POST "$GITLAB_URL/api/v4/projects/$USUARIO%2F$PROYECTO/members" \
    -d "user_id=$ID_MIEMBRO" -d access_level=30 >/dev/null
  echo "Miembro: $MIEMBRO, con rol Developer"
  preparar_pc "$MIEMBRO" "$ID_MIEMBRO"
  [ "$CLONAR" = 0 ] || clonar_en "$MIEMBRO"
fi

[ -z "$PREPARAR" ] || preparar_pc "$PREPARAR" "$ID_PREPARAR"
