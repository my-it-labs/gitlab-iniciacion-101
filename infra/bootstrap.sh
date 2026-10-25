#!/usr/bin/env bash
# Arranca GitLab CE, el runner y los ordenadores del equipo; registra el runner y crea los usuarios.
# Idempotente. Deja GITLAB_URL y GITLAB_TOKEN (root, scope api) en infra/.env (gitignored).
# Uso: infra/bootstrap.sh
set -euo pipefail
cd "$(dirname "$0")"

# usuario:Nombre: cada uno tiene su ordenador pc-<usuario> en compose.yaml
USUARIOS=(ana:Ana luis:Luis)
PASS_ALUMNO="${PASS_ALUMNO:-Formacion-2026!}"
PORT="${GITLAB_PORT:-8080}"
URL="http://localhost:$PORT"
dc() { docker compose -f compose.yaml "$@"; }

echo "[1/5] Arrancando GitLab, runner y ordenadores del equipo…"
# Carpetas personales de los ordenadores: se crean antes para que sean del usuario del Codespace.
mkdir -p ../home-ana ../home-luis
dc up -d --build

echo "[2/5] Esperando a GitLab (la primera vez, 3-6 min)…"
for _ in $(seq 1 120); do
  code=$(curl -s -o /dev/null -w '%{http_code}' "$URL/users/sign_in" || true)
  [ "$code" = 200 ] && break
  sleep 5
done
[ "$code" = 200 ] || { echo "GitLab no responde: dc logs gitlab"; exit 1; }

echo "[3/5] Token de administración…"
TOKEN=$(sed -n 's/^GITLAB_TOKEN=//p' .env 2>/dev/null || true)
# Vale si funciona en esta instancia y tiene scope sudo (partida.sh lanza pipelines en nombre del usuario).
if [ -n "$TOKEN" ] && curl -sf -o /dev/null -H "PRIVATE-TOKEN: $TOKEN" -H "Sudo: root" "$URL/api/v4/user"; then
  printf 'GITLAB_URL=%s\nGITLAB_TOKEN=%s\n' "$URL" "$TOKEN" > .env
else
  TOKEN="glpat-curso-$(head -c 12 /dev/urandom | od -An -tx1 | tr -d ' \n')"
  dc exec -T gitlab gitlab-rails runner "
    u = User.find_by_username('root')
    t = u.personal_access_tokens.create!(name: 'curso', scopes: [:api, :sudo], expires_at: 90.days.from_now)
    t.set_token('$TOKEN'); t.save!" >/dev/null
  printf 'GITLAB_URL=%s\nGITLAB_TOKEN=%s\n' "$URL" "$TOKEN" > .env
fi
api() { curl -sf -H "PRIVATE-TOKEN: $TOKEN" "$@"; }

echo "[4/5] Runner…"
if dc exec -T runner gitlab-runner list 2>&1 | grep -q 'Executor.*=docker'; then
  echo "    ya registrado"
else
  RTOKEN=$(api -X POST "$URL/api/v4/user/runners" -d runner_type=instance_type -d run_untagged=true \
    -d description=runner-curso | sed -n 's/.*"token":"\([^"]*\)".*/\1/p')
  dc exec -T runner gitlab-runner register --non-interactive \
    --url "http://gitlab:$PORT" --clone-url "http://gitlab:$PORT" --token "$RTOKEN" \
    --executor docker --docker-image alpine:3.20 --docker-network-mode gitlab-curso >/dev/null 2>&1
  echo "    registrado"
fi

echo "[5/5] Usuarios…"
for par in "${USUARIOS[@]}"; do
  u="${par%%:*}"; nombre="${par#*:}"
  if api "$URL/api/v4/users?username=$u" | grep -q "\"username\":\"$u\""; then
    echo "    $u ya existe"
  else
    api -X POST "$URL/api/v4/users" -d username="$u" -d name="$nombre" -d email="$u@equipo.local" \
      -d password="$PASS_ALUMNO" -d skip_confirmation=true >/dev/null
    echo "    $u creado"
  fi
done

echo
echo "GitLab listo: $URL  ·  usuarios: ana luis  ·  contraseña: $PASS_ALUMNO"
echo "Ordenadores: docker exec -it pc-ana bash  ·  docker exec -it pc-luis bash"
