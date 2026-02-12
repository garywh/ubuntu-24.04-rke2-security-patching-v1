#!/usr/bin/env bash
set -euo pipefail
KUBECTL_BIN="${KUBECTL_BIN:-kubectl}"
$KUBECTL_BIN get --raw='/readyz' >/dev/null
$KUBECTL_BIN get nodes -o wide
$KUBECTL_BIN -n kube-system get pods -o wide || true
$KUBECTL_BIN get pdb -A 2>/dev/null || true
