#!/usr/bin/env bash
# Arranca GitLab CE (con registro de imágenes en gitlab:5050), el runner y los ordenadores
# del equipo; registra el runner y crea los usuarios.
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

# El registro escucha en gitlab:5050 por HTTP. El nombre tiene que resolver en esta máquina
# y el daemon de Docker tiene que aceptar ese registro; si no, docker push/pull falla.
preparar_docker_registro() {
  if ! grep -qE '[[:space:]]gitlab$' /etc/hosts; then
    echo '127.0.0.1 gitlab' | sudo tee -a /etc/hosts >/dev/null
    echo "    nombre gitlab apuntando a esta máquina"
  fi
  local marca
  marca=$(sudo python3 - <<'PY'
import json, sys
p = "/etc/docker/daemon.json"
with open(p) as f:
    cfg = json.load(f)
regs = list(cfg.get("insecure-registries") or [])
if "gitlab:5050" in regs:
    print("ok")
    sys.exit(0)
regs.append("gitlab:5050")
cfg["insecure-registries"] = regs
with open(p, "w") as f:
    json.dump(cfg, f, indent=4)
    f.write("\n")
print("changed")
PY
)
  if [ "$marca" = "changed" ]; then
    echo "    reiniciando Docker para aceptar http://gitlab:5050"
    sudo service docker restart
    local i
    for i in $(seq 1 30); do
      docker info >/dev/null 2>&1 && break
      sleep 1
    done
    docker info >/dev/null 2>&1 || { echo "Docker no ha vuelto tras el reinicio" >&2; exit 1; }
  fi
}

preparar_docker_registro

echo "[1/5] Arrancando GitLab, runner y ordenadores del equipo…"
docker pull -q docker:27-cli >/tmp/curso-pull-docker-cli.log 2>&1 &
PULL_CLI=$!
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
echo "    esperando al registro de imágenes…"
reg=000
for _ in $(seq 1 60); do
  reg=$(curl -s -o /dev/null -w '%{http_code}' "http://gitlab:5050/v2/" || true)
  [ "$reg" = "401" ] || [ "$reg" = "200" ] && break
  sleep 5
done
[ "$reg" = "401" ] || [ "$reg" = "200" ] || { echo "El registro no responde en gitlab:5050 (HTTP $reg)"; exit 1; }

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
  if ! dc exec -T runner grep -q "url = \"http://gitlab:$PORT\"" /etc/gitlab-runner/config.toml; then
    dc exec -T runner sed -i "s#http://gitlab:[0-9]*#http://gitlab:$PORT#g" /etc/gitlab-runner/config.toml
    dc restart runner >/dev/null
    echo "    runner apuntando a http://gitlab:$PORT"
  fi
else
  RTOKEN=$(api -X POST "$URL/api/v4/user/runners" -d runner_type=instance_type -d run_untagged=true \
    -d description=runner-curso | sed -n 's/.*"token":"\([^"]*\)".*/\1/p')
  dc exec -T runner gitlab-runner register --non-interactive \
    --url "http://gitlab:$PORT" --clone-url "http://gitlab:$PORT" --token "$RTOKEN" \
    --executor docker --docker-image alpine:3.20 --docker-network-mode gitlab-curso \
    --docker-volumes /var/run/docker.sock:/var/run/docker.sock >/dev/null 2>&1
  echo "    registrado"
fi
if ! dc exec -T runner grep -q 'docker.sock' /etc/gitlab-runner/config.toml; then
  dc exec -T runner sed -i 's#volumes = \["/cache"\]#volumes = ["/cache", "/var/run/docker.sock:/var/run/docker.sock"]#' /etc/gitlab-runner/config.toml
  dc restart runner >/dev/null
fi
if ! dc exec -T runner grep -q 'docker.sock' /etc/gitlab-runner/config.toml; then
  echo "No se ha podido montar docker.sock en el runner:" >&2
  dc exec -T runner cat /etc/gitlab-runner/config.toml >&2
  exit 1
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

wait "$PULL_CLI" || { echo "No se ha podido descargar docker:27-cli" >&2; cat /tmp/curso-pull-docker-cli.log >&2; exit 1; }

echo
echo "GitLab listo: $URL  ·  usuarios: ana luis  ·  contraseña: $PASS_ALUMNO"
echo "Registro de imágenes: gitlab:5050"
echo "Ordenadores: docker exec -it pc-ana bash  ·  docker exec -it pc-luis bash"
