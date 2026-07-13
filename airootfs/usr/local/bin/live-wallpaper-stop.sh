#!/usr/bin/env bash
# Stop Jker-OS live wallpaper
PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/jker-live-wall.pid"
if [[ -f "${PIDFILE}" ]]; then
    kill "$(cat "${PIDFILE}")" 2>/dev/null || true
    rm -f "${PIDFILE}"
fi
