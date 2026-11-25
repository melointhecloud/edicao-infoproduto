#!/usr/bin/env bash
# Exit 0 only when the engine accepts this clone's MCP token.
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"

ROOT="$(skill_repo)"
FILE="$ROOT/.local/mcp-token"
if [[ ! -s "$FILE" ]]; then
  echo "FALHA: sem .local/mcp-token" >&2
  exit 1
fi
if ! port_open; then
  echo "FALHA: nada escuta em 127.0.0.1:5199" >&2
  exit 1
fi
TOKEN="$(tr -d '[:space:]' <"$FILE")"
CODE="$(curl -sS -o /tmp/edicao-infoproduto-mcp-body.txt -w '%{http_code}' \
  -X POST "http://127.0.0.1:5199/api/external-mcp/mcp" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"edicao-infoproduto","version":"1"}}}')"
if [[ "$CODE" != "200" ]]; then
  echo "FALHA: MCP respondeu HTTP $CODE. O token desta pasta não foi aceito." >&2
  exit 1
fi
if ! grep -q 'openchatcut' /tmp/edicao-infoproduto-mcp-body.txt && ! grep -q 'serverInfo' /tmp/edicao-infoproduto-mcp-body.txt; then
  echo "FALHA: a porta abriu, mas a resposta não é o MCP do OpenChatCut." >&2
  exit 1
fi
echo "OK: motor no ar e token aceito."
