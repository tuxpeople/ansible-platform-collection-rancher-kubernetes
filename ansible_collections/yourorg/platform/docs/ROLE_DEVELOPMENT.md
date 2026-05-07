# Rollenentwicklung

## Neue Rolle anlegen

```bash
cd ansible_collections/yourorg/platform
ansible-galaxy role init roles/<role_name>
```

Danach ergänzen:

- `meta/argument_specs.yml`
- `molecule/default/`
- `README.md`
- Tests und Verify-Schritte

## Namenskonventionen

- Rollenname: `snake_case`
- Variablenprefix: `<role_name>_`
- Handlername: sprechend, z.B. `Restart rke2-server`
- Tags: `role_name`, `install`, `configure`, `service`, `verify`
