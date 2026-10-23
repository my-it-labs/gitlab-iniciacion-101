# M03 — Ramas, fusiones y resolución de conflictos

[← Página anterior](../M02-operaciones-basicas/04-lab-gitignore.md) · [Siguiente página →](00-ramas-como-punteros.md)

Una página nueva del manual no debería verse a medias en la rama principal mientras la escribes. Aquí la trabajas en una rama, la fusionas cuando está lista y ves qué pasa cuando dos ramas cambian las mismas líneas de la misma página.

## Qué aprenderás

- Trabajar una página nueva del manual sin tocar lo que ya está publicado
- Crear, cambiar y borrar ramas sin perder trabajo
- Fusionar una rama terminada en la principal
- Leer las marcas de un conflicto y decidir con qué texto se queda el manual
- Poner a commits y ramas nombres que el equipo entienda meses después

## Teoría

Una **rama** es un nombre que apunta a un commit. Al hacer un commit en una rama, el nombre avanza al commit nuevo. `HEAD` indica en qué rama estás.

| Comando | Qué hace |
|---------|----------|
| `git switch -c <rama>` | Crea la rama y te cambia a ella |
| `git switch <rama>` | Cambia a una rama que ya existe |
| `git branch` | Lista las ramas locales y marca la actual |
| `git merge <rama>` | Incorpora a la rama actual los commits de `<rama>` |
| `git branch -d <rama>` | Borra la rama si ya está fusionada |

Una fusión puede acabar de dos formas:

| Caso | Qué hace Git |
|------|--------------|
| La principal no ha cambiado desde que creaste la rama | *Fast-forward*: mueve el puntero, sin commit nuevo |
| Las dos ramas tienen commits propios | Crea un **commit de merge** con dos padres |

Hay **conflicto** cuando las dos ramas cambian las mismas líneas del mismo archivo. Git no elige por ti: marca el trozo con `<<<<<<<`, `=======` y `>>>>>>>`, y espera a que lo dejes como debe quedar, lo prepares con `git add` y confirmes con `git commit`.

> [!NOTE]
> Un conflicto no es un error ni se ha roto nada. Es Git preguntándote qué texto se queda.

## Páginas

| # | Página | Qué hay |
|---|--------|---------|
| 00 | [Ramas como punteros](00-ramas-como-punteros.md) | Demostración: una rama, dos commits y su fusión vistos en el grafo |
| 01 | [Lab — Rama y merge](01-lab-rama-y-merge.md) | Escribes una página nueva en su rama y la fusionas con la principal |
| 02 | [Lab — Conflicto](02-lab-conflicto.md) | Provocas un conflicto en la misma página desde dos ramas, lo resuelves y lo publicas |
| 03 | [Buenas prácticas de commits y ramas](03-buenas-practicas.md) | Mensajes de commit y nombres de rama que se entienden después |

→ Empieza por **[00 — Ramas como punteros](00-ramas-como-punteros.md)**.
