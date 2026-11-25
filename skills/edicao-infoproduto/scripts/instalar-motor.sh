#!/usr/bin/env bash
# Install the OpenChatCut engine into this clone. Linux x86_64 extracts the
# AppImage with unsquashfs. The published AppImage runtime hangs on Ubuntu
# before opening a window. macOS and Windows print the installer URL.
set -euo pipefail
source "$(cd "$(dirname "$0")" && pwd)/lib.sh"

VERSION="0.2.17"
ROOT="$(skill_repo)"
OS="$(uname -s)"
ARCH="$(uname -m)"
RELEASE="https://github.com/0xsline/OpenChatCut/releases/download/v${VERSION}"

ensure_dirs "$ROOT"
ensure_token "$ROOT"

need() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Falta o comando $1. No Ubuntu: sudo apt install $2" >&2
    exit 1
  fi
}

case "$OS" in
  Darwin)
    if [[ "$ARCH" == "arm64" ]]; then
      echo "${RELEASE}/OpenChatCut-${VERSION}-arm64.dmg"
    else
      echo "${RELEASE}/OpenChatCut-${VERSION}-x64.dmg"
    fi
    echo "Baixe o .dmg, arraste o OpenChatCut para Aplicativos e abra uma vez. Depois rode scripts/abrir-openchatcut.sh a partir deste repositório." >&2
    exit 2
    ;;
  MINGW* | MSYS* | CYGWIN*)
    echo "${RELEASE}/OpenChatCut-${VERSION}-x64.exe"
    echo "Instale o .exe, abra o OpenChatCut uma vez e rode o setup de novo." >&2
    exit 2
    ;;
  Linux) ;;
  *)
    echo "Sistema não suportado: $OS $ARCH" >&2
    exit 2
    ;;
esac

if [[ "$ARCH" != "x86_64" ]]; then
  echo "O AppImage oficial é só x86_64. Esta máquina é $ARCH." >&2
  exit 2
fi

need curl curl
need unsquashfs squashfs-tools
need ffmpeg ffmpeg
need openssl openssl

if engine_dir "$ROOT" >/dev/null; then
  echo "Motor já extraído em $(engine_dir "$ROOT")"
  exit 0
fi

APPIMAGE="$ROOT/.local/OpenChatCut-${VERSION}-x86_64.AppImage"
if [[ ! -f "$APPIMAGE" && -f "$ROOT/OpenChatCut-${VERSION}-x86_64.AppImage" ]]; then
  APPIMAGE="$ROOT/OpenChatCut-${VERSION}-x86_64.AppImage"
fi

if [[ ! -f "$APPIMAGE" ]]; then
  echo "Baixando o AppImage..."
  curl -fL --retry 3 -o "$ROOT/.local/OpenChatCut-${VERSION}-x86_64.AppImage.partial" \
    "${RELEASE}/OpenChatCut-${VERSION}-x86_64.AppImage"
  mv "$ROOT/.local/OpenChatCut-${VERSION}-x86_64.AppImage.partial" \
    "$ROOT/.local/OpenChatCut-${VERSION}-x86_64.AppImage"
  APPIMAGE="$ROOT/.local/OpenChatCut-${VERSION}-x86_64.AppImage"
  chmod +x "$APPIMAGE"
fi

SUMS="$(mktemp)"
curl -fsSL -o "$SUMS" "${RELEASE}/SHA256SUMS.txt"
(
  cd "$(dirname "$APPIMAGE")"
  grep " $(basename "$APPIMAGE")\$" "$SUMS" | sha256sum -c -
)
rm -f "$SUMS"

DEST="$ROOT/.local/openchatcut-app"
rm -rf "$DEST"
offset="$("$APPIMAGE" --appimage-offset)"
unsquashfs -o "$offset" -d "$DEST" "$APPIMAGE" >/dev/null

if [[ ! -f "$DEST/snapshot_blob.bin" || ! -f "$DEST/v8_context_snapshot.bin" ]]; then
  echo "A extração saiu sem os arquivos de arranque do Electron. Não use --appimage-extract." >&2
  exit 1
fi
echo "Motor extraído em $DEST"
