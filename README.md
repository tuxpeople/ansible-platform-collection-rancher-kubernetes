# tuxpeople.rancher_kubernetes

Ansible Collection für Plattform-Automation rund um RKE2, Harbor Registry
und Rancher Manager.

## Collection

FQCN: `tuxpeople.rancher_kubernetes`

## Unterstützte Plattformen

| OS | Version | Status |
| --- | --- | --- |
| Ubuntu | 24.04 (noble) | Primäres Ziel – getestet |
| Rocky Linux | 9 | Geplant – in Entwicklung |

Helm-Rollen (`harbor`, `rancher`) laufen auf dem Ansible-Controller und
sind OS-agnostisch.

## Rollen

| Rolle | Zweck | OS-spezifisch |
| --- | --- | --- |
| `common` | Basis-Konfiguration für Linux-Nodes | Ja |
| `rke2` | RKE2 Kubernetes (Template) | Ja |
| `harbor` | Harbor Registry via Helm (Template) | Nein |
| `rancher` | Rancher Manager via Helm (Template) | Nein |

## Struktur

```text
galaxy.yml
roles/
  common/
  rke2/
  harbor/
  rancher/
playbooks/
plugins/
docs/
tests/
CHANGELOG.rst
AGENTS.md
requirements.yml
requirements-dev.txt
.ansible-lint
.yamllint
.github/workflows/ci.yml
```

## Lokaler Start

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements-dev.txt
ansible-galaxy collection install -r requirements.yml -p collections
```

## Qualitätssicherung

```bash
yamllint .
ansible-lint .
ansible-test sanity --docker default -v
```

Rollen-Tests mit Molecule:

```bash
cd roles/common
molecule test
```

## Beispiel-Playbook

```bash
ansible-playbook -i inventories/example/hosts.yml playbooks/bootstrap.yml
```

## Repository-Philosophie

Die Collection bleibt generisch. Kunden-, Umgebungs- oder
cluster-spezifische Werte gehören in separate Inventory-Repositories.
Siehe `docs/ROLE_DEVELOPMENT.md` für Entwicklungsrichtlinien.
