#!/usr/bin/env bash
set -euo pipefail
KUBECTL_BIN="${KUBECTL_BIN:-kubectl}"
NODE=""
MODE="safe"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --node) NODE="$2"; shift 2 ;;
    --mode) MODE="$2"; shift 2 ;;
    *) echo "Usage: $0 --node <node> [--mode safe|delete-emptydir|force]" >&2; exit 1 ;;
  esac
done

[[ -n "$NODE" ]] || { echo "Missing --node" >&2; exit 1; }

$KUBECTL_BIN cordon "$NODE"
ARGS=(drain "$NODE" --ignore-daemonsets --grace-period=60 --timeout=20m)
case "$MODE" in
  safe) ;;
  delete-emptydir) ARGS+=(--delete-emptydir-data) ;;
  force) ARGS+=(--force) ;;
  *) echo "Invalid mode: $MODE" >&2; exit 1 ;;
esac
$KUBECTL_BIN "${ARGS[@]}"
