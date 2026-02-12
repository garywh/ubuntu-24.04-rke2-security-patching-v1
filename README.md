# Ubuntu 24.04 RKE2 Security Patching

Production-grade runbooks, checklists, and helper scripts for safely applying Ubuntu 24.04 LTS security updates to nodes running RKE2 (control-plane/etcd and workers). Built for audited production environments.

Repo layout:
- docs/ – strategy, architecture, risk matrix, templates
- runbooks/ – control-plane, worker, emergency, rollback
- scripts/ – prechecks, drain, patch, health checks
- checklists/ – pre/post checklists + audit evidence pack template
