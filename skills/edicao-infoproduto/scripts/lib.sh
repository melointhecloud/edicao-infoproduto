#!/usr/bin/env bash
# Shared paths for the edição-infoproduto scripts. Source this file.

skill_repo() {
  local d
  d="$(cd "$(dirname "${BASH_SOURCE[1]}")" && pwd)"
  while [[ "$d" != "/" ]]; do
    if [[ -f "$d/skills/edicao-infoproduto/SKILL.md" ]]; then
      printf '%s\n' "$d"
      return 0
    fi
    d="$(dirname "$d")"
  done
  echo "Abra a pasta clonada da skill. Este script não achou skills/edicao-infoproduto/SKILL.md." >&2
  return 1
}

engine_dir() {
  local root="$1"
  local candidate
  for candidate in "$root/openchatcut-app" "$root/.local/openchatcut-app"; do
    if [[ -x "$candidate/AppRun" && -f "$candidate/snapshot_blob.bin" && -f "$candidate/v8_context_snapshot.bin" ]]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done
  return 1
}

ensure_dirs() {
  local root="$1"
  mkdir -p "$root/entrada" "$root/saida" "$root/banco" "$root/trilhas" "$root/.local"
}

ensure_token() {
  local root="$1"
  local file="$root/.local/mcp-token"
  ensure_dirs "$root"
  if [[ ! -s "$file" ]]; then
    openssl rand -hex 32 >"$file"
    chmod 600 "$file"
  fi
}

port_open() {
  ss -ltn 2>/dev/null | grep -q '127.0.0.1:5199'
}
