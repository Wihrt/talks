#!/usr/bin/env bash
# Copie la démo dans un repo git neuf, prêt pour le live.
#   ./prepare.sh [destination]   (défaut : /tmp/terragrunt-demo)
# get_repo_root() et --filter-affected s'appuient sur git :
# la démo doit donc vivre dans son propre repo, pas dans celui des talks.
set -euo pipefail

src="$(cd "$(dirname "$0")" && pwd)"
dest="${1:-/tmp/terragrunt-demo}"

rm -rf "$dest"
mkdir -p "$dest"
cp -R "$src/." "$dest/"
rm -f "$dest/prepare.sh" "$dest/README.md"

cd "$dest"
git init -q -b main
git add -A
git -c user.name=demo -c user.email=demo@example.com commit -qm "Socle initial"
# Le catalogue est versionné par tag : scaffold veut une source git::...?ref=
git tag v1
echo "Démo prête dans $dest"
