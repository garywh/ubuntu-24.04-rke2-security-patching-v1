# Ubuntu 24.04 RKE2 Security Patching Toolkit

This repository provides an operational toolkit for planning, executing, validating, and documenting **security patching for RKE2 clusters running on Ubuntu 24.04**.

It includes practical runbooks, patching scripts, readiness checklists, and architecture/security documentation to support repeatable maintenance windows.

## What’s Included

- **Automation scripts** for prechecks, node draining, patch execution, and health validation
- **Step-by-step runbooks** for deployment, worker-node patching, verification, rollback, and incident response
- **Operational checklists** for pre-patch, post-patch, and security audit evidence collection
- **Supporting documentation** for architecture, prerequisites, strategy, troubleshooting, and security considerations

## Repository Layout

```text
.
├── checklists/           # Pre/post patch and audit checklists
├── docs/                 # Architecture, strategy, prerequisites, troubleshooting, etc.
├── runbooks/             # Execution and operational response runbooks
├── scripts/              # Shell scripts used during patching operations
├── CONTRIBUTING.md       # Contribution guidelines
└── README.md
```

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/garywh/ubuntu-24.04-rke2-security-patching-v1.git
   cd ubuntu-24.04-rke2-security-patching-v1
   ```
2. Review prerequisites:
   - [`docs/PREREQUISITES.md`](docs/PREREQUISITES.md)
3. Read the onboarding and execution flow:
   - [`docs/GETTING_STARTED.md`](docs/GETTING_STARTED.md)
   - [`runbooks/patch-deployment.md`](runbooks/patch-deployment.md)
4. Execute prechecks before making changes:
   ```bash
   ./scripts/precheck.sh
   ```

## Typical Patching Workflow

1. Complete the **pre-patch checklist**: [`checklists/pre-patch-checklist.md`](checklists/pre-patch-checklist.md)
2. Run prechecks and validate baseline health:
   ```bash
   ./scripts/precheck.sh
   ./scripts/health-check.sh --scope cluster
   ```
3. Drain and patch target node(s):
   ```bash
   ./scripts/drain-node.sh --node <node-name> --mode safe
   ./scripts/patch-node.sh --role server    # or --role agent
   ```
4. Run post-patch validation:
   ```bash
   ./scripts/health-check.sh --scope cluster
   ```
5. Complete post-patch and audit artifacts:
   - [`checklists/post-patch-checklist.md`](checklists/post-patch-checklist.md)
   - [`checklists/audit-evidence-template.md`](checklists/audit-evidence-template.md)

## Core Documentation

- Architecture: [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)
- Patching Strategy: [`docs/patching-strategy.md`](docs/patching-strategy.md)
- Security Considerations: [`docs/SECURITY_CONSIDERATIONS.md`](docs/SECURITY_CONSIDERATIONS.md)
- Troubleshooting: [`docs/TROUBLESHOOTING.md`](docs/TROUBLESHOOTING.md)
- Rollback: [`runbooks/rollback-procedures.md`](runbooks/rollback-procedures.md)
- Incident Response: [`runbooks/incident-response.md`](runbooks/incident-response.md)

## Contributing

Contributions are welcome. Please review [`CONTRIBUTING.md`](CONTRIBUTING.md) before opening a pull request.
