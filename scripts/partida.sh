#!/usr/bin/env bash
# Prepara el punto de partida de una página: crea en GitLab un proyecto con el manual
# del equipo, con un historial inicial, y lo clona en ~/trabajo/<proyecto>.
#
# Uso: scripts/partida.sh <proyecto> [--con-ci] [--solo-remoto]
#   --con-ci       incluye .gitlab-ci.yml (validar + construir)
#   --solo-remoto  no clona en local
#
# Lee GITLAB_URL y GITLAB_TOKEN de ~/.curso-gitlab (si no existe, los pide y lo crea).
set -euo pipefail

RAIZ="$(cd "$(dirname "$0")/.." && pwd)"
ORIGEN="$RAIZ/proyecto/manual-equipo"
CONFIG="$HOME/.curso-gitlab"

[ $# -ge 1 ] || { sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//'; exit 2; }
PROYECTO="$1"; shift
CON_CI=0; CLONAR=1
for op in "$@"; do
  case "$op" in
    --con-ci) CON_CI=1 ;;
    --solo-remoto) CLONAR=0 ;;
    *) echo "Opción desconocida: $op" >&2; exit 2 ;;
  esac
done

if [ ! -f "$CONFIG" ]; then
  read -rp "URL de GitLab (p. ej. https://gitlab.ejemplo.com): " url
  read -rsp "Token de acceso personal (scopes api y write_repository): " token; echo
  printf 'GITLAB_URL=%s\nGITLAB_TOKEN=%s\n' "${url%/}" "$token" > "$CONFIG"
  chmod 600 "$CONFIG"
fi
# shellcheck disable=SC1090
. "$CONFIG"

api() { curl -sS -f -H "PRIVATE-TOKEN: $GITLAB_TOKEN" "$@"; }
campo() { sed -n "s/.*\"$1\":\"\{0,1\}\([^\",}]*\).*/\1/p" | head -n 1; }

USUARIO=$(api "$GITLAB_URL/api/v4/user" | campo username)
[ -n "$USUARIO" ] || { echo "No se pudo identificar el usuario: revisa $CONFIG" >&2; exit 1; }

if api "$GITLAB_URL/api/v4/projects/$USUARIO%2F$PROYECTO" >/dev/null 2>&1; then
  echo "Ya existe $USUARIO/$PROYECTO en GitLab. Usa otro nombre, p. ej. $PROYECTO-2" >&2
  exit 1
fi

echo "Creando $USUARIO/$PROYECTO en GitLab…"
ID=$(api -X POST "$GITLAB_URL/api/v4/projects" -d "name=$PROYECTO" -d "path=$PROYECTO" \
  -d visibility=private -d initialize_with_readme=false | campo id)

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
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
git push -q "$ESQUEMA://oauth2:$GITLAB_TOKEN@$HOST/$USUARIO/$PROYECTO.git" main

URL_PROYECTO="$GITLAB_URL/$USUARIO/$PROYECTO"
echo "Proyecto: $URL_PROYECTO"
if [ "$CLONAR" = 1 ]; then
  DESTINO="$HOME/trabajo/$PROYECTO"
  if [ -e "$DESTINO" ]; then
    echo "Ya existe $DESTINO: no se clona (bórralo o usa otro nombre)" >&2
    exit 1
  fi
  mkdir -p "$HOME/trabajo"
  git clone -q "$ESQUEMA://oauth2:$GITLAB_TOKEN@$HOST/$USUARIO/$PROYECTO.git" "$DESTINO"
  git -C "$DESTINO" remote set-url origin "$URL_PROYECTO.git"
  git -C "$DESTINO" config credential.helper store
  printf '%s://%s:%s@%s\n' "$ESQUEMA" "$USUARIO" "$GITLAB_TOKEN" "$HOST" >> "$HOME/.git-credentials"
  chmod 600 "$HOME/.git-credentials"
  echo "Copia local: $DESTINO"
fi
