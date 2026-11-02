#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "=== Compilation LuaLaTeX : passe 1/2 ==="
lualatex --interaction=nonstopmode main.tex

echo "=== Compilation LuaLaTeX : passe 2/2 (table des matières) ==="
lualatex --interaction=nonstopmode main.tex

echo "=== Terminé : main.pdf ==="
