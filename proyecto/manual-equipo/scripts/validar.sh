#!/bin/sh
# Comprueba las páginas del manual: título en la primera línea y enlaces internos que existen.
errores=0
for f in README.md docs/*.md; do
  [ -f "$f" ] || continue
  primera=$(grep -v '^[[:space:]]*$' "$f" | head -n 1)
  case "$primera" in
    "# "*) ;;
    *) echo "ERROR $f: falta el título (la primera línea debe empezar por '# ')"; errores=$((errores + 1)) ;;
  esac
  dir=$(dirname "$f")
  for enlace in $(grep -o '](\([^)#:]*\.md\))' "$f" | sed 's/^](\(.*\))$/\1/'); do
    if [ ! -f "$dir/$enlace" ]; then
      echo "ERROR $f: enlace roto a $enlace"; errores=$((errores + 1))
    fi
  done
  echo "revisado $f"
done
if [ "$errores" -gt 0 ]; then
  echo "$errores error(es)"; exit 1
fi
echo "Todas las páginas son correctas"
