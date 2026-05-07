# tuxpeople.rancher_kubernetes

Ansible Collection für Plattform-Automation rund um RKE2, Harbor Registry
und Rancher Manager.

## Collection

FQCN: `tuxpeople.rancher_kubernetes`

## Rollen

- `tuxpeople.rancher_kubernetes.common` – Basis-Konfiguration für
  Linux-Systeme
- `tuxpeople.rancher_kubernetes.rke2` – RKE2-Basisrolle (Template)
- `tuxpeople.rancher_kubernetes.harbor` – Harbor-Deployment via Helm
  (Template)
- `tuxpeople.rancher_kubernetes.rancher` – Rancher Manager via Helm
  (Template)

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
