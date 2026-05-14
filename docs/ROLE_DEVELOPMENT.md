# Rollenentwicklung

## Neue Rolle anlegen

```bash
ansible-galaxy role init roles/<role_name>
```

Danach ergänzen:

- `meta/argument_specs.yml`
- `molecule/default/`
- `README.md`
- Tests und Verify-Schritte

Läuft die Rolle auf Linux-Nodes (nicht nur Helm/k8s API):

- `vars/Debian.yml` mit `_<role>_`-Variablen für Ubuntu 24.04
- `vars/RedHat.yml` mit `_<role>_`-Variablen für Rocky 9 (TODO-Kommentar
  wenn noch ungetestet)
- OS-Assert und `include_vars` als erste zwei Tasks in `tasks/main.yml`

## Namenskonventionen

- Rollenname: `snake_case`
- Variablenprefix öffentlich: `<role_name>_`
- Variablenprefix intern (OS-spezifisch): `_<role_name>_`
- Handlername: sprechend, z.B. `Restart rke2-server`
- Tags: `role_name`, `install`, `configure`, `service`, `verify`

## OS-Unterstützung

### Entwicklungsreihenfolge

1. Feature auf **Ubuntu 24.04** entwickeln und mit Molecule testen
2. `meta/main.yml` um Ubuntu noble ergänzen (nur nach grünem Test)
3. `vars/RedHat.yml` mit TODO befüllen (Werte bereits vorbereiten)
4. Feature auf **Rocky Linux 9** testen (zweites Molecule-Szenario oder
   erweitertes Szenario)
5. TODO in `vars/RedHat.yml` entfernen, `meta/main.yml` um Rocky 9 ergänzen

### Template für neue Linux-Rolle (tasks/main.yml Anfang)

```yaml
- name: Assert supported OS family
  ansible.builtin.assert:
    that:
      - ansible_os_family in ['Debian', 'RedHat']
    fail_msg: >-
      Unsupported OS family: {{ ansible_os_family }}.
      Supported: Debian (Ubuntu 24.04), RedHat (Rocky 9).
  tags:
    - <role_name>

- name: Load OS-specific variables
  ansible.builtin.include_vars: "{{ ansible_os_family }}.yml"
  tags:
    - <role_name>
```

### Template vars/Debian.yml

```yaml
---
# OS-spezifische Variablen fuer Debian/Ubuntu
# Getestet: Ubuntu 24.04 (noble)
_<role_name>_packages:
  - paket1
  - paket2
```

### Template vars/RedHat.yml

```yaml
---
# OS-spezifische Variablen fuer RedHat/Rocky/AlmaLinux
# TODO: Testen auf Rocky Linux 9
_<role_name>_packages:
  - paket1
  - paket2-rhel-variant
```

### Helm-/k8s-Rollen (harbor, rancher)

Rollen, die ausschliesslich gegen die Kubernetes API arbeiten, brauchen kein
OS-Vars-Muster. Sie laufen auf dem Ansible-Controller, nicht auf den Nodes.
