# M04 — Trabajo colaborativo en GitLab

[← Página anterior](../M03-ramas-y-conflictos/03-buenas-practicas.md) · [Siguiente página →](00-roles-issues-y-mr.md)

El proyecto lo mantiene un equipo, no una persona. Ana y Luis comparten un proyecto: cada cambio nace en una issue, se propone en una merge request y lo revisa la otra persona antes de entrar en una rama principal que nadie puede tocar directamente. Haces de los dos, con el ordenador de cada uno y una sesión de GitLab para cada uno (Ana en una ventana normal, Luis en una privada): [El entorno de prácticas](../../infra/README.md).

## Qué aprenderás

- Dar acceso a `manual-equipo` a otra persona del equipo con el rol justo
- Impedir que nadie suba cambios directamente a la rama principal
- Registrar como issue una mejora o un error del proyecto
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
> En GitLab 19 las issues están en **Plan → Work items**: un *work item* es cualquier elemento de trabajo, y una issue es uno de sus tipos. El botón para crearla es **New item**, el formulario se titula **New issue** y se confirma con **Create issue**.

> [!NOTE]
> Una **rama protegida** no impide trabajar: impide hacer push directo a ella. Los cambios llegan por merge request, y solo los roles permitidos pueden fusionarla.

## Páginas

<!-- gen:paginas -->
| # | Página | Qué hay |
|---|--------|---------|
| 00 | [Roles, issues y merge requests](00-roles-issues-y-mr.md) | Demostración: de la issue a la MR fusionada, con una sugerencia de cambio |
| 01 | [Lab — Proyecto compartido](01-lab-proyecto-compartido.md) | Como Ana, invitas a Luis con su rol y proteges la rama principal |
| 02 | [Lab — De la issue a la merge request](02-lab-de-issue-a-mr.md) | Como Luis, registras una issue, haces el cambio en una rama y abres la MR enlazada |
| 03 | [Lab — Revisión](03-lab-revision.md) | Como Ana, revisas la MR de Luis, pides un cambio y completas la fusión |

→ Empieza por **[00 — Roles, issues y merge requests](00-roles-issues-y-mr.md)**.
<!-- /gen:paginas -->
