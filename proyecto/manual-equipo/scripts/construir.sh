#!/bin/sh
# Junta todas las páginas del manual en public/manual-completo.md
set -e
mkdir -p public
{
  cat README.md
  for f in docs/*.md; do
    printf '\n\n---\n\n'
    cat "$f"
  done
} > public/manual-completo.md
echo "Generado public/manual-completo.md ($(wc -l < public/manual-completo.md) líneas)"
