# Ubuntu 24.04 RKE2 Security Patching v1

Operational toolkit and runbook set for planning, executing, and validating security patching on Ubuntu 24.04 hosts running RKE2.

## What this repository includes

- **Automation scripts** for pre-checks, node drain, package patching, and post-patch health validation.
- **Runbooks** for deployment sequencing, rollback, worker-node patching, and incident response.
- **Checklists/templates** to support repeatable execution and audit evidence collection.
- **Supporting docs** covering architecture, prerequisites, troubleshooting, and security considerations.

## Repository structure

```text
ubuntu-24.04-rke2-security-patching-v1/
├── scripts/      # Operational shell scripts used during patching
├── runbooks/     # Step-by-step operational procedures
├── checklists/   # Pre/post/audit checklists and templates
├── docs/         # Reference documentation
├── CONTRIBUTING.md
└── README.md
```

## Prerequisites

- Ubuntu 24.04 nodes participating in an RKE2 cluster.
- Cluster administration access (`kubectl` with required RBAC).
- Root/sudo privileges on nodes for OS package updates.
- A reviewed maintenance window and rollback plan.

See also: `docs/PREREQUISITES.md`.

## Quick start

1. Clone the repository:

   ```bash
   git clone https://github.com/garywh/ubuntu-24.04-rke2-security-patching-v1.git
   cd ubuntu-24.04-rke2-security-patching-v1
   ```

2. Run cluster pre-checks:

   ```bash
   ./scripts/precheck.sh
   ```

3. Drain a target node before patching:

   ```bash
   ./scripts/drain-node.sh --node <node-name> --mode safe
   ```

4. Apply OS patches on the node (exit code `10` means reboot required):

   ```bash
   sudo ./scripts/patch-node.sh --role server
   # or
   sudo ./scripts/patch-node.sh --role agent
   ```

5. Validate cluster or node health after patching:

   ```bash
   ./scripts/health-check.sh --scope cluster
   # or
   ./scripts/health-check.sh --scope node --node <node-name>
   ```

## Suggested operational flow

1. Use `checklists/pre-patch-checklist.md`.
2. Follow `runbooks/patch-deployment.md`.
3. Use `runbooks/verification-checklist.md` and `checklists/post-patch-checklist.md`.
4. Capture evidence in `checklists/audit-evidence-template.md`.
5. If needed, follow `runbooks/rollback-procedures.md`.

## Documentation index

- `docs/GETTING_STARTED.md`
- `docs/ARCHITECTURE.md`
- `docs/SECURITY_CONSIDERATIONS.md`
- `docs/TROUBLESHOOTING.md`
- `docs/patching-strategy.md`

## Contributing

Contributions are welcome. Please review `CONTRIBUTING.md` before submitting changes.

## GitLab CI/CD (Ansible automation)

A GitLab pipeline is included in `.gitlab-ci.yml` to run the patching workflow with Ansible on runners tagged `ansible`.

- **lint**: runs `ansible-lint` and playbook syntax checks.
- **dry-run**: executes a full `--check --diff` plan for `precheck`, `patch`, and `verify` tags.
- **patch**: manual production apply job (`precheck,patch`).
- **verify**: runs verification checks (`verify`) after patching.

### Pipeline inputs

- Inventory: `ansible/inventory/hosts.ini`
- Playbook: `ansible/playbooks/rke2-security-patching.yml`
- Optional var: `patch_batch_size` to control rolling concurrency.

Update `ansible/inventory/hosts.ini` with your hostnames/IPs before running non-check-mode jobs.
