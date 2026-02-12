# Patching strategy (Ubuntu 24.04 + RKE2)

Defaults:
- Control-plane: one node at a time, always maintain quorum.
- Drains respect PDBs by default; no --force unless explicitly approved.
- Reboot only when required (/var/run/reboot-required).
- This repo covers OS patching only (not RKE2 upgrades).
