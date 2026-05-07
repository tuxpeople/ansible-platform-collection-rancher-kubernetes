# Role: tuxpeople.rancher_kubernetes.common

Basis-Konfiguration für Linux-Systeme.

## Requirements

- Ansible Core >= 2.16
- Collection dependencies siehe `requirements.yml`

## Role Variables

Siehe `defaults/main.yml` und `meta/argument_specs.yml`.

## Example Playbook

```yaml
- name: Use common role
  hosts: all
  become: true
  roles:
    - role: tuxpeople.rancher_kubernetes.common
```

## Testing

```bash
cd ansible_collections/tuxpeople/platform/roles/common
molecule test
```

## Security Notes

Keine Secrets in Rollenvariablen ablegen. Produktive Werte aus Inventory, Vault oder Secret Store beziehen.
