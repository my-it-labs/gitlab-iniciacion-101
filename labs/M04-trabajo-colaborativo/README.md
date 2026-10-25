# M04 — Trabajo colaborativo en GitLab

[← Página anterior](../M03-ramas-y-conflictos/03-buenas-practicas.md) · [Siguiente página →](00-roles-issues-y-mr.md)

El manual lo mantiene un equipo, no una persona. En parejas compartís un proyecto. Cada cambio nace en una issue, se propone en una merge request y lo revisa el compañero antes de entrar en una rama principal que nadie puede tocar directamente.

## Qué aprenderás

- Dar acceso a `manual-equipo` a un compañero con el rol justo
- Impedir que nadie suba cambios directamente a la rama principal
- Registrar como issue una mejora o un error del manual
- Llevar un cambio de la issue a la merge request, enlazados entre sí
- Revisar la merge request de otra persona, comentar y sugerir cambios
- Completar la fusión y cerrar la issue con ella

## Teoría

| Rol | Qué puede hacer en el proyecto |
|-----|-------------------------------|
| Guest | Ver el proyecto y crear issues |
| Reporter | Lo anterior y leer el código |
| Developer | Crear ramas, hacer push a ramas no protegidas y abrir merge requests |
| Maintainer | Lo anterior y configurar el proyecto: miembros, ramas protegidas, fusionar en `main` |
| Owner | Control total, incluido borrar el proyecto |

| Pieza | Para qué sirve |
|-------|----------------|
| **Issue** | Registrar qué hay que hacer o qué falla, y discutirlo |
| **Rama** | Hacer el cambio sin tocar `main` |
| **Merge request (MR)** | Proponer que la rama entre en `main`: diff, comentarios, revisión y fusión |

Si la descripción de la MR incluye `Closes #<número>`, la issue se cierra sola al fusionar.

> [!NOTE]
> Una **rama protegida** no impide trabajar: impide hacer push directo a ella. Los cambios llegan por merge request, y solo los roles permitidos pueden fusionarla.

## Páginas

<!-- gen:paginas -->
| # | Página | Qué hay |
|---|--------|---------|
| 00 | [Roles, issues y merge requests](00-roles-issues-y-mr.md) | Demostración: de la issue a la MR fusionada, con una sugerencia de cambio |
| 01 | [Lab — Proyecto compartido](01-lab-proyecto-compartido.md) | Invitas a tu pareja con su rol y proteges la rama principal |
| 02 | [Lab — De la issue a la merge request](02-lab-de-issue-a-mr.md) | Registras una issue, haces el cambio en una rama y abres la MR enlazada |
| 03 | [Lab — Revisión](03-lab-revision.md) | Revisas la MR de tu pareja, pides un cambio y completas la fusión |

→ Empieza por **[00 — Roles, issues y merge requests](00-roles-issues-y-mr.md)**.
<!-- /gen:paginas -->
