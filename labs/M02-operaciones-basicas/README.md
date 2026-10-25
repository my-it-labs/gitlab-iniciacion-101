# M02 — Operaciones básicas con repositorios

[← Página anterior](../M01-introduccion-git-gitlab/02-lab-primer-proyecto.md) · [Siguiente página →](00-ciclo-de-un-cambio.md)

`manual-equipo` ya existe en GitLab, pero solo se puede editar desde la web. Aquí Ana lo trae a su ordenador, edita sus páginas y registra cada cambio en un commit. Después lo consulta, lo compara y lo publica, y deja fuera del repositorio lo que solo es suyo. Casi todo ocurre en el ordenador de Ana (`docker exec -it pc-ana bash`); GitLab se usa para comprobar lo publicado. Cómo se entra en cada sitio: [El entorno de prácticas](../../infra/README.md).

## Qué aprenderás

- Tener en el ordenador de Ana una copia de `manual-equipo` enlazada con GitLab por SSH
- Saber en todo momento qué páginas se han cambiado y cuáles están listas para el commit
- Separar cambios distintos del proyecto en commits distintos con mensajes claros
- Encontrar quién cambió una línea del proyecto y qué cambió exactamente
- Publicar los commits en GitLab y traer los que hayan hecho otros
- Evitar que copias de seguridad del editor o borradores locales acaben en el repositorio

## Teoría

| Comando | Qué hace | Toca la red |
|---------|----------|-------------|
| `git clone <url>` | Copia el repositorio remoto entero y lo enlaza como `origin` | Sí |
| `git status` | Dice qué archivos han cambiado y en qué área están | No |
| `git add <archivo>` | Pasa el cambio al área de preparación | No |
| `git commit -m "…"` | Guarda lo preparado como un commit | No |
| `git log` | Lista los commits, del más reciente al más antiguo | No |
| `git diff` | Muestra las líneas cambiadas que aún no están preparadas | No |
| `git push` | Sube tus commits a GitLab | Sí |
| `git fetch` | Trae los commits nuevos de GitLab sin tocar tus archivos | Sí |
| `git pull` | `fetch` y además incorpora esos commits a tu rama | Sí |

Un archivo puede estar en cuatro estados: **sin seguimiento** (Git aún no lo conoce), **modificado**, **preparado** o **confirmado** (guardado en un commit). `git status` siempre te dice en cuál está.

> [!NOTE]
> `git commit` no publica nada: el commit queda solo en el ordenador donde se hizo hasta que se hace `git push`. Si en GitLab no ves el cambio, casi siempre es eso.

> [!NOTE]
> `.gitignore` solo afecta a archivos **sin seguimiento**. Si un archivo ya está en un commit, añadirlo a `.gitignore` no lo saca del repositorio.

## Páginas

<!-- gen:paginas -->
| # | Página | Qué hay |
|---|--------|---------|
| 00 | [El ciclo de un cambio](00-ciclo-de-un-cambio.md) | Demostración: de editar una página en el ordenador de Ana a verla publicada en GitLab |
| 01 | [Lab — Clonar](01-lab-clonar.md) | Clonas el proyecto por SSH en el ordenador de Ana y lees el estado de sus archivos |
| 02 | [Lab — Commits](02-lab-commits.md) | Modificas varias páginas y las registras en commits separados |
| 03 | [Lab — Publicar y comparar](03-lab-publicar-y-comparar.md) | Subes tus commits y consultas `log` y `diff` en local y en GitLab |
| 04 | [Lab — .gitignore](04-lab-gitignore.md) | Excluyes del repositorio los archivos locales que no son del proyecto |

→ Empieza por **[00 — El ciclo de un cambio](00-ciclo-de-un-cambio.md)**.
<!-- /gen:paginas -->
