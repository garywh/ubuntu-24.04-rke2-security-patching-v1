#!/usr/bin/env bash
set -euo pipefail
ROLE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --role) ROLE="$2"; shift 2 ;;
    *) echo "Usage: $0 --role server|agent" >&2; exit 1 ;;
  esac
done

[[ "$ROLE" == "server" || "$ROLE" == "agent" ]] || { echo "Invalid role" >&2; exit 1; }

apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
DEBIAN_FRONTEND=noninteractive apt-get autoremove -y || true

[[ -f /var/run/reboot-required ]] && exit 10 || exit 0
