# Ansible Platform Collection Template

Template für ein Git-Repository mit einer internen Ansible Collection für Plattform-Automation, z.B. RKE2, Harbor Registry, Rancher Manager und weitere Kubernetes-nahe Komponenten.

## Collection

Namespace: `yourorg`  
Name: `platform`  
FQCN: `yourorg.platform`

Passe diese Platzhalter in folgenden Dateien an:

- `ansible_collections/yourorg/platform/galaxy.yml`
- `ansible_collections/yourorg/platform/README.md`
- Rollen-README-Dateien
- Beispiel-Playbooks
- CI Workflow

## Struktur

```text
ansible_collections/yourorg/platform/
  roles/
    common/
    rke2/
    harbor/
    rancher/
  playbooks/
  plugins/
  docs/
  tests/
  galaxy.yml
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
ansible-galaxy collection install -r requirements.yml
```

## Qualitätssicherung

```bash
yamllint .
ansible-lint .
ansible-test sanity --docker default -v
```

Rollen-Tests mit Molecule, Beispiel:

```bash
cd ansible_collections/yourorg/platform/roles/common
molecule test
```

## Beispiel-Playbook

```bash
ansible-playbook -i inventories/example/hosts.yml ansible_collections/yourorg/platform/playbooks/bootstrap.yml
```

## Repository-Philosophie

Die Collection bleibt generisch. Kunden-, Umgebungs- oder Cluster-spezifische Werte gehören in separate Inventory-Repositories.
