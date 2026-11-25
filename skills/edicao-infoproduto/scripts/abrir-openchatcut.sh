#!/usr/bin/env bash
# Start the extracted OpenChatCut engine. The window is the engine. Leave it
# open, minimized. --background returns after the local port answers.
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"

ROOT="$(skill_repo)"
BACKGROUND=0
if [[ "${1:-}" == "--background" ]]; then
  BACKGROUND=1
fi

ensure_token "$ROOT"
APPDIR="$(engine_dir "$ROOT" || true)"
if [[ -z "$APPDIR" ]]; then
  echo "Motor ausente. Rode skills/edicao-infoproduto/scripts/instalar-motor.sh" >&2
  exit 1
fi

TOKEN="$(tr -d '[:space:]' <"$ROOT/.local/mcp-token")"
LOG="$ROOT/.local/openchatcut.log"

if port_open; then
  echo "OpenChatCut já responde em http://127.0.0.1:5199"
  exit 0
fi

export OPENCHATCUT_MCP_TOKEN="$TOKEN"
unset ELECTRON_RUN_AS_NODE

if [[ "$BACKGROUND" -eq 1 ]]; then
  # shellcheck disable=SC2091
  nohup "$APPDIR/AppRun" >>"$LOG" 2>&1 &
  echo $! >"$ROOT/.local/openchatcut.pid"
  for _ in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
    if port_open; then
      echo "OpenChatCut no ar em http://127.0.0.1:5199"
      exit 0
    fi
    sleep 1
  done
  echo "O motor não abriu a porta 5199. Últimas linhas do log:" >&2
  tail -n 40 "$LOG" >&2 || true
  exit 1
fi

cd "$APPDIR"
exec "$APPDIR/AppRun"
