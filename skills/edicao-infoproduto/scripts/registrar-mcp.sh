#!/usr/bin/env bash
# Register the local OpenChatCut MCP server in the user Grok config.
# The token stays in .local/mcp-token and in the user config, never in git.
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"

ROOT="$(skill_repo)"
FILE="$ROOT/.local/mcp-token"
if [[ ! -s "$FILE" ]]; then
  echo "Token ausente. Rode scripts/abrir-openchatcut.sh --background antes." >&2
  exit 1
fi
TOKEN="$(tr -d '[:space:]' <"$FILE")"
URL="http://127.0.0.1:5199/api/external-mcp/mcp"

if command -v grok >/dev/null 2>&1; then
  grok mcp remove openchatcut >/dev/null 2>&1 || true
  grok mcp add --transport http --scope user openchatcut "$URL" \
    --header "Authorization: Bearer ${TOKEN}"
  echo "MCP openchatcut registrado no Grok do usuário."
else
  echo "grok não está no PATH. Em outro cliente, registre o HTTP MCP:"
  echo "  url: $URL"
  echo "  header: Authorization: Bearer <conteúdo de .local/mcp-token>"
  exit 1
fi
