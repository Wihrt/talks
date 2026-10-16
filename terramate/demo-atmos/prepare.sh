#!/usr/bin/env bash
# Copie la démo dans un repo git neuf, prêt pour le live.
#   ./prepare.sh [destination]   (défaut : /tmp/atmos-demo)
# `atmos describe affected` compare deux commits git :
# la démo doit donc vivre dans son propre repo, pas dans celui des talks.
set -euo pipefail

src="$(cd "$(dirname "$0")" && pwd)"
dest="${1:-/tmp/atmos-demo}"

rm -rf "$dest"
mkdir -p "$dest"
cp -R "$src/." "$dest/"
rm -f "$dest/prepare.sh" "$dest/README.md"

cd "$dest"
git init -q -b main
git add -A
git -c user.name=demo -c user.email=demo@example.com commit -qm "Socle initial"
echo "Démo prête dans $dest"
