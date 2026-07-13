#!/usr/bin/env bash
# Jker-OS live animated wallpaper — mpv loop behind KDE Plasma desktop
set -euo pipefail

WALLPAPER="/usr/share/jker-os/assets/jker-live-wall.mp4"
PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/jker-live-wall.pid"

if [[ ! -f "${WALLPAPER}" ]]; then
    echo "Jker-OS: wallpaper asset not found at ${WALLPAPER}" >&2
    exit 0
fi

if [[ -f "${PIDFILE}" ]]; then
    kill "$(cat "${PIDFILE}")" 2>/dev/null || true
    rm -f "${PIDFILE}"
fi

# Wait for Plasma shell to register its desktop window
DESKTOP_WID=""
for _ in $(seq 1 30); do
    DESKTOP_WID="$(xwininfo -root -tree 2>/dev/null | awk '/plasmashell/ {print $1; exit}')"
    [[ -n "${DESKTOP_WID}" ]] && break
    sleep 1
done

if [[ -z "${DESKTOP_WID}" ]]; then
    echo "Jker-OS: could not find plasmashell window — skipping live wallpaper." >&2
    exit 0
fi

mpv \
    --wid="${DESKTOP_WID}" \
    --no-audio \
    --loop=inf \
    --no-input-default-bindings \
    --no-osc \
    --no-osd-bar \
    --no-border \
    --hwdec=auto \
    "${WALLPAPER}" &

echo $! > "${PIDFILE}"
