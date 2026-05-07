# Role: tuxpeople.rancher_kubernetes.rke2

Template-Rolle für RKE2-Installation und Konfiguration.

## Requirements

- Ansible Core >= 2.16
- Collection dependencies siehe `requirements.yml`

## Role Variables

Siehe `defaults/main.yml` und `meta/argument_specs.yml`.

## Example Playbook

```yaml
- name: Use rke2 role
  hosts: all
  become: true
  roles:
    - role: tuxpeople.rancher_kubernetes.rke2
```

## Testing

```bash
cd ansible_collections/tuxpeople/platform/roles/rke2
molecule test
```

## Security Notes

Keine Secrets in Rollenvariablen ablegen. Produktive Werte aus Inventory, Vault oder Secret Store beziehen.
