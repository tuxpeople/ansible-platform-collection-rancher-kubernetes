#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <namespace> <collection_name>" >&2
  echo "Example: $0 acme platform" >&2
  exit 1
fi

namespace="$1"
collection="$2"
old_path="ansible_collections/yourorg/platform"
new_path="ansible_collections/${namespace}/${collection}"

mkdir -p "ansible_collections/${namespace}"
mv "$old_path" "$new_path"
find . -type f \
  -not -path './.git/*' \
  -not -path './.venv/*' \
  -print0 | xargs -0 sed -i.bak \
  -e "s/yourorg\.platform/${namespace}.${collection}/g" \
  -e "s/yourorg/${namespace}/g" \
  -e "s/name: platform/name: ${collection}/g"
find . -name '*.bak' -delete

echo "Renamed collection to ${namespace}.${collection}"
