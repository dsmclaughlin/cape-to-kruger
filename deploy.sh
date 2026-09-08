#!/usr/bin/env bash
# Rebuild the locked page from the private planning repo and deploy to GitHub Pages.
set -euo pipefail
SRC="$HOME/Repos/pe/sa-2027-planning/page"
cd "$SRC"
python3 build.py
python3 lock.py "$@"
cp sa2027-locked.html "$HOME/Repos/pe/cape-to-kruger/index.html"
cd "$HOME/Repos/pe/cape-to-kruger"
git add index.html
git commit -qm "Update itinerary $(date +%Y-%m-%d)" || { echo "No changes."; exit 0; }
git push -q origin main
echo "Deployed. Live in ~1 min: https://dsmclaughlin.github.io/cape-to-kruger/"
