#!/usr/bin/env bash
# Jker-OS asset downloader — run before archiso mkarchiso build
# Pulls placeholder cyberpunk neon video loop for live wallpaper

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSET_DIR="${SCRIPT_DIR}/airootfs/usr/share/jker-os/assets"
GRUB_THEME_DIR="${SCRIPT_DIR}/airootfs/usr/share/grub/themes/jker-grub"
GRUB_ISO_THEME_DIR="${SCRIPT_DIR}/grub/themes/jker-grub"
WALLPAPER="${ASSET_DIR}/jker-live-wall.mp4"
DESKTOP_BG="${ASSET_DIR}/jker-desktop-bg.png"
GRUB_BG="${GRUB_THEME_DIR}/background.png"

# Placeholder: short royalty-free video loop (replace with custom cyberpunk/neon asset)
WALLPAPER_URL="https://motionbgs.com/edgewalker"
# Placeholder: dark neon gradient desktop background
DESKTOP_BG_URL="https://motionbgs.com/dark-king-and-the-crown-of-thorns"

mkdir -p "${ASSET_DIR}" "${GRUB_THEME_DIR}" "${GRUB_ISO_THEME_DIR}"

download() {
    local url="$1"
    local dest="$2"
    if command -v curl &>/dev/null; then
        curl -fL --retry 3 --retry-delay 2 -o "${dest}" "${url}"
    elif command -v wget &>/dev/null; then
        wget -O "${dest}" "${url}"
    else
        echo "ERROR: curl or wget required to download assets." >&2
        exit 1
    fi
}

echo "==> Jker-OS: downloading live wallpaper video..."
download "${WALLPAPER_URL}" "${WALLPAPER}"
echo "    Saved: ${WALLPAPER}"

echo "==> Jker-OS: downloading desktop background..."
download "${DESKTOP_BG_URL}" "${DESKTOP_BG}"
echo "    Saved: ${DESKTOP_BG}"

echo "==> Jker-OS: copying GRUB theme background..."
cp "${DESKTOP_BG}" "${GRUB_BG}"
cp "${GRUB_BG}" "${GRUB_ISO_THEME_DIR}/background.png"

echo "==> Asset download complete."
