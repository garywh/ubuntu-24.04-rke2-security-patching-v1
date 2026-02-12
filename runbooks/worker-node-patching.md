# Runbook: Worker (rke2-agent) patching

1) Run prechecks:
   ./scripts/precheck.sh

2) Cordon and drain:
   NODE=<node>
   kubectl cordon "$NODE"
   ./scripts/drain-node.sh --node "$NODE" --mode safe

3) Patch on node (SSH):
   sudo -i
   ./scripts/patch-node.sh --role agent
   # exit 10 => reboot required

4) Verify:
   ./scripts/health-check.sh --scope cluster
   kubectl uncordon "$NODE"
