# Role: tuxpeople.rancher_kubernetes.rancher

Template-Rolle für Rancher Manager Deployment.

## Requirements

- Ansible Core >= 2.16
- Collection dependencies siehe `requirements.yml`

## Role Variables

Siehe `defaults/main.yml` und `meta/argument_specs.yml`.

## Example Playbook

```yaml
- name: Use rancher role
  hosts: all
  become: true
  roles:
    - role: tuxpeople.rancher_kubernetes.rancher
```

## Testing

```bash
cd ansible_collections/tuxpeople/platform/roles/rancher
molecule test
```

## Security Notes

Keine Secrets in Rollenvariablen ablegen. Produktive Werte aus Inventory, Vault oder Secret Store beziehen.
