#!/usr/bin/env bash
# rename-collection.sh – Namespace und Collection-Name im gesamten Repo ersetzen.
# Nutzung: ./scripts/rename-collection.sh <namespace> <collection_name>
# Beispiel: ./scripts/rename-collection.sh acme my_platform
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <namespace> <collection_name>" >&2
  echo "Example: $0 acme my_platform" >&2
  exit 1
fi

namespace="$1"
collection="$2"
old_ns="tuxpeople"
old_col="rancher_kubernetes"

find . -type f \
  -not -path './.git/*' \
  -not -path './.venv/*' \
  -not -path './collections/*' \
  -print0 | xargs -0 sed -i '' \
  -e "s/${old_ns}\.${old_col}/${namespace}.${collection}/g" \
  -e "s/namespace: ${old_ns}/namespace: ${namespace}/g" \
  -e "s/name: ${old_col}/name: ${collection}/g"

echo "Renamed collection to ${namespace}.${collection}"
echo "Review galaxy.yml, README.md and AGENTS.md for any remaining references."
