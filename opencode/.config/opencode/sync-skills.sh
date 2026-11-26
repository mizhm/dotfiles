#!/usr/bin/env bash
# Re-vendor the skills listed in skills.sources into skills/<frontmatter name>.
set -euo pipefail
cd "$(dirname "$0")"
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT

grep -Ev '^\s*(#|$)' skills.sources | while read -r repo path; do
  src="$tmp/${repo//\//__}"
  [ -d "$src" ] || git clone -q --depth 1 "https://github.com/$repo" "$src"
  [ -f "$src/$path/SKILL.md" ] || { echo "missing: $repo/$path" >&2; exit 1; }
  name=$(sed -n 's/^name:[[:space:]]*//p' "$src/$path/SKILL.md" | head -1 | tr -d "\"'")
  [[ $name =~ ^[a-z0-9-]+$ ]] || { echo "bad name '$name': $repo/$path" >&2; exit 1; }
  rm -rf "skills/$name"
  cp -r "$src/$path" "skills/$name"
  echo "$name <- $repo/$path@$(git -C "$src" rev-parse --short HEAD)"
done
