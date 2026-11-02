#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v pdffonts >/dev/null 2>&1; then
  echo "ERREUR : pdffonts est introuvable."
  echo "Installez poppler-utils : sudo apt install poppler-utils"
  exit 1
fi

echo "=== Compilation du document de test ==="
lualatex --interaction=nonstopmode test-font.tex > /tmp/test-font.log 2>&1

echo
echo "=== Polices réellement intégrées dans le PDF ==="
pdffonts test-font.pdf

echo
if pdffonts test-font.pdf | grep -q "JetBrainsMono-Bold"; then
  echo "OK : JetBrains Mono Bold est bien utilisée pour le code."
else
  echo "ECHEC : JetBrains Mono Bold n'est pas utilisée."
  echo "Vérifiez le dossier fonts/ et la section \\setmonofont de preamble.tex."
  exit 1
fi

if pdffonts test-font.pdf | grep -q "JetBrainsMono-BoldItalic"; then
  echo "OK : la variante Bold Italic est aussi utilisée pour les commentaires."
else
  echo "NOTE : la variante Bold Italic n'apparaît pas dans ce test."
fi

echo
echo "PDF de contrôle : test-font.pdf"

rm -f test-font.aux test-font.log test-font.out test-font.toc \
      test-font.listing test-font.lof test-font.lot test-font.synctex.gz
