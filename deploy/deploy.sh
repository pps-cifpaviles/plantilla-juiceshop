#!/usr/bin/env bash
# Despliega Juice Shop desde el código del repositorio en pps-dev.
# Uso (desde el pipeline):  deploy/deploy.sh <host>     Necesita: ALUMNO
set -euo pipefail

HOST=${1:?Uso: deploy.sh <host>}
: "${ALUMNO:?Falta la variable ALUMNO del repositorio}"
export JS_PORT=$((20000 + 10#$ALUMNO * 100 + 20))
PROYECTO="a${ALUMNO}-juiceshop"

cd "$(dirname "$0")"
docker compose -p "$PROYECTO" -f compose.yml up -d --build --remove-orphans

echo "Comprobando la aplicación…"
for _ in $(seq 1 40); do
  if curl -fs "http://localhost:${JS_PORT}/rest/admin/application-version" >/dev/null; then
    echo "OK · http://${HOST}:${JS_PORT}"
    [ -n "${GITHUB_STEP_SUMMARY:-}" ] && echo "Juice Shop en http://${HOST}:${JS_PORT}" >> "$GITHUB_STEP_SUMMARY"
    exit 0
  fi
  sleep 5
done
echo "Juice Shop no responde. Últimos logs:" >&2
docker compose -p "$PROYECTO" -f compose.yml logs --tail 50 >&2
exit 1
