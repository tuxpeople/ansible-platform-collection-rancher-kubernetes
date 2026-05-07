# AGENTS.md – KI-Leitplanken für diese Ansible Collection

## Ziel

Entwickle wiederverwendbare, sichere, idempotente und getestete Ansible-Rollen
innerhalb der Collection `tuxpeople.rancher_kubernetes`.

Typische Rollen in dieser Collection:

- `common`
- `rke2`
- `harbor`
- `rancher`
- weitere Plattform-Komponenten wie `longhorn`, `cert_manager`,
  `ingress_nginx`, `metallb`, `monitoring`, `backup`

## Grundregeln

1. Idempotenz ist Pflicht.
   - Wiederholte Runs dürfen keine unnötigen Changes erzeugen.
   - `shell` und `command` nur verwenden, wenn es kein passendes Modul gibt.
   - Bei `shell`/`command` immer `changed_when`, `failed_when`, `creates`,
     `removes` oder eine klare Begründung nutzen.

2. Keine Secrets im Repository.
   - Keine Passwörter, Tokens, Private Keys, kubeconfigs oder Zertifikate
     committen.
   - Secrets nur als Variablennamen dokumentieren.
   - Beispielwerte müssen klar als Dummy-Werte erkennbar sein.

3. Rollen sind generisch.
   - Keine kundenspezifischen Hostnamen, IP-Adressen, Domains oder Pfade
     hardcoden.
   - Alles Umgebungsabhängige gehört in Inventory, `group_vars`, `host_vars`
     oder externe Secret Stores.

4. Nutze FQCNs.
   - Immer `ansible.builtin.template` statt `template`.
   - Für Kubernetes/Helm bevorzugt `kubernetes.core.*` verwenden.

5. Explizite Rechte.
   - Datei- und Verzeichnis-Modi immer als String setzen, z.B. `"0644"`.
   - Owner und Group angeben, wenn Dateien auf Zielsystemen erstellt werden.

6. Handler statt direkter Restarts.
   - Konfigurationsänderungen triggern Handler via `notify`.
   - Services nicht unnötig neu starten.

7. Klare Variablenschnittstelle.
   - Öffentliche Variablen liegen in `defaults/main.yml`.
   - Rollenspezifischer Prefix ist Pflicht, z.B. `rke2_`, `harbor_`,
     `rancher_`.
   - Interne Variablen nach Möglichkeit in `vars/main.yml` oder lokal im
     Task-Block halten.

8. Argument Validation.
   - Jede Rolle pflegt `meta/argument_specs.yml`.
   - Öffentliche Variablen müssen Typ, Beschreibung und
     Default/Required-Status haben.

9. Dokumentation.
   - Jede Rolle hat ein `README.md` mit Zweck, Variablen, Beispiel, Tags,
     Dependencies und Einschränkungen.
   - Jede Annahme muss dokumentiert werden.

10. Tests.

    - Jede Rolle enthält mindestens ein Molecule-Szenario.
    - Pflicht: converge, idempotence und verify.
    - Wo Container-Tests nicht sinnvoll sind, muss dies im Rollen-README
      begründet werden.

## Architektur-Leitplanken

### Collection bleibt generisch

Diese Collection enthält wiederverwendbare Rollen und Playbooks.
Sie enthält keine produktiven Inventories.

Nicht hierhin gehören:

- konkrete Cluster-Inventories
- Kundenwerte
- produktive Domains
- produktive Zertifikate
- Vault-Dateien mit Echtdaten

### Empfohlene Trennung

```text
platform-collection/       # diese Collection
customer-platform-config/  # Inventory, group_vars, site.yml, Secrets
```

## Rollen-Design

Beim Erstellen oder Ändern einer Rolle zuerst ein kurzes Design liefern:

- Ziel und Nicht-Ziele
- unterstützte Betriebssysteme
- benötigte Collections
- öffentliche Variablen
- Task-Struktur
- Handler
- Templates
- Tests
- Sicherheitsannahmen

Erst danach Code generieren.

## Rollenstruktur

```text
roles/<role_name>/
  defaults/main.yml
  vars/main.yml              # nur falls nötig
  tasks/main.yml
  handlers/main.yml          # falls Services/Daemons betroffen sind
  templates/                 # falls Templates verwendet werden
  files/                     # nur statische, nicht geheime Dateien
  meta/main.yml
  meta/argument_specs.yml
  molecule/default/
  README.md
```

## Task-Stil

Gute Tasks:

```yaml
- name: Render RKE2 config file
  ansible.builtin.template:
    src: config.yaml.j2
    dest: /etc/rancher/rke2/config.yaml
    owner: root
    group: root
    mode: "0600"
  notify: Restart rke2-server
```

Schlechte Tasks:

```yaml
- shell: curl -sfL https://get.rke2.io | sh -
```

Falls externe Installer notwendig sind, Download, Prüfsummen, Versionierung
und Ausführung trennen.

## Kubernetes- und Helm-Leitplanken

- Helm-Releases deklarativ mit `kubernetes.core.helm` verwalten.
- Namespaces explizit erzeugen.
- Chart-Versionen pinnen.
- Wartebedingungen definieren, wo sinnvoll.
- Keine kubeconfig im Repository ablegen.
- `validate_certs: false` nur mit Begründung und nur als bewusst gesetzte
  Variable.

## Security Defaults

- Sichere Defaults bevorzugen.
- Keine Dienste unnötig auf `0.0.0.0` binden.
- TLS nicht deaktivieren.
- Admin-Passwörter nicht automatisch generieren und ausgeben, außer explizit
  als nicht-produktiver Dev-Modus gekennzeichnet.
- Privilegierte Tasks nur mit `become: true` auf Task- oder Block-Ebene.

## Linting und Tests

Vor Abschluss müssen folgende Befehle erfolgreich sein:

```bash
yamllint .
ansible-lint .
ansible-test sanity --docker default -v
```

Für geänderte Rollen zusätzlich:

```bash
cd roles/<role_name>
molecule test
```

## Definition of Done

Eine Änderung ist erst fertig, wenn:

- Tasks idempotent sind
- öffentliche Variablen dokumentiert sind
- `argument_specs.yml` gepflegt ist
- README aktualisiert ist
- keine Secrets enthalten sind
- Linting erfolgreich ist
- Molecule-Szenario vorhanden oder begründet ausgenommen ist
- Beispiel-Playbook weiterhin lauffähig ist
