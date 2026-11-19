#!/usr/bin/env bash
# Copie la démo dans un repo git neuf, prêt pour le live.
#   ./prepare.sh [destination]   (défaut : /tmp/terraspace-demo)
# Terraspace n'a pas besoin de git ; le repo sert à montrer les commits, comme pour Terramate.
set -euo pipefail

src="$(cd "$(dirname "$0")" && pwd)"
dest="${1:-/tmp/terraspace-demo}"

rm -rf "$dest"
mkdir -p "$dest"
cp -R "$src/." "$dest/"
rm -f "$dest/prepare.sh" "$dest/README.md"

cd "$dest"
git init -q -b main
git add -A
git -c user.name=demo -c user.email=demo@example.com commit -qm "Socle initial"
echo "Démo prête dans $dest"
