#!/usr/bin/env bash
set -euo pipefail
KUBECTL_BIN="${KUBECTL_BIN:-kubectl}"
SCOPE=""
NODE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --scope) SCOPE="$2"; shift 2 ;;
    --node) NODE="$2"; shift 2 ;;
    *) echo "Usage: $0 --scope cluster|node [--node <node>]" >&2; exit 1 ;;
  esac
done

[[ -n "$SCOPE" ]] || { echo "Missing --scope" >&2; exit 1; }

$KUBECTL_BIN get --raw='/readyz' >/dev/null
$KUBECTL_BIN get nodes
$KUBECTL_BIN -n kube-system get pods 2>/dev/null | awk 'NR==1 || ($3!="Running" && $3!="Succeeded"){print}' || true

if [[ "$SCOPE" == "node" ]]; then
  [[ -n "$NODE" ]] || { echo "--node required for node scope" >&2; exit 1; }
  $KUBECTL_BIN get pods -A -o wide --field-selector spec.nodeName="$NODE" 2>/dev/null \
    | awk 'NR==1 || ($4!="Running" && $4!="Succeeded"){print}' || true
fi
