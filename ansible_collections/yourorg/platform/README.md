# yourorg.platform

Interne Ansible Collection für Plattform-Automation.

## Rollen

- `yourorg.platform.common` – Basis-Konfiguration für Linux-Systeme
- `yourorg.platform.rke2` – RKE2-Basisrolle als Template
- `yourorg.platform.harbor` – Harbor-Deployment als Template
- `yourorg.platform.rancher` – Rancher Manager Deployment als Template

## Installation

```bash
ansible-galaxy collection build ansible_collections/yourorg/platform
ansible-galaxy collection install yourorg-platform-*.tar.gz
```

## Beispiel

```yaml
- name: Bootstrap platform
  hosts: all
  become: true
  roles:
    - yourorg.platform.common
```

## Hinweise

Diese Collection enthält bewusst keine produktiven Inventories oder Secrets.
