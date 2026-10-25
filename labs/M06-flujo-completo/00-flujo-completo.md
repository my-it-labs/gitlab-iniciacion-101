# El flujo completo y los errores habituales

[← Página anterior](README.md) · [Siguiente página →](01-lab-flujo-completo.md)

El proyecto ya tiene todo lo que hace falta para trabajar en serio: un repositorio ordenado, `main` protegida, issues, merge requests y un pipeline que valida cada cambio. Esta página junta lo que hace que ese proyecto siga siendo fácil de mantener cuando lo tocan muchas personas: dónde va cada cosa, cómo se deja un historial que se lee solo y qué errores aparecen una y otra vez.

## Un repositorio que se entiende al abrirlo

Quien llega nuevo al proyecto `manual-equipo` no pregunta por dónde empezar: abre el proyecto en GitLab y lo primero que ve es el `README.md`. Cada archivo de la raíz tiene un trabajo concreto:

| Elemento | Qué contiene en el proyecto | Por qué está ahí |
|----------|---------------------------|------------------|
| `README.md` | Qué es el proyecto, el índice de páginas y «Cómo se mantiene» | Es la puerta de entrada: GitLab lo muestra en la página del proyecto |
| `docs/` | Las páginas: `bienvenida.md`, `herramientas.md`, `normas-de-trabajo.md` | El contenido, separado de lo que lo hace funcionar |
| `scripts/` | `validar.sh` y `construir.sh` | Las comprobaciones se pueden lanzar igual en el ordenador de cada persona y en el pipeline |
| `.gitignore` | Lo que nunca debe entrar en un commit | Evita subir lo generado o lo personal |
| `.gitlab-ci.yml` | Los stages `validar` y `construir` | El pipeline vive con el código y cambia por merge request, como todo lo demás |

Una página nueva no existe para el equipo hasta que se puede llegar a ella. Por eso, en este proyecto, crear `docs/algo.md` siempre va acompañado de su enlace en el índice del `README.md` y, si amplía otra página, de un enlace desde esa página. El pipeline lo vigila en parte: `validar.sh` falla si un enlace apunta a un archivo que no existe, pero no avisa de una página a la que nadie enlaza.

> [!TIP]
> El proyecto no trae `.gitignore`, y `construir.sh` genera `public/manual-completo.md` cuando se ejecuta en el ordenador de alguien. Tras ejecutarlo, `git status` lo enseña como `Untracked files: public/`. Una línea `public/` en `.gitignore` evita que un `git add .` lo meta en el historial: ese archivo lo genera el pipeline como artefacto, no se versiona.

### Quién mantiene qué

| Parte | Quién la cambia | Cómo |
|-------|-----------------|------|
| Páginas de `docs/` | Cualquier Developer del proyecto | Rama y merge request |
| `README.md` (índice) | Quien añade o quita una página, en la misma MR | Rama y merge request |
| `scripts/` y `.gitlab-ci.yml` | Quien conoce el pipeline; lo revisa un Maintainer | Rama y merge request, con el pipeline en verde |
| Miembros, ramas protegidas | Maintainer | **Settings** y **Manage → Members** |

La sección «Cómo se mantiene» del `README.md` es el sitio para dejar esto por escrito: quien llega no tiene que adivinar las reglas.

## Un historial que se lee solo

El historial es la documentación de cómo ha llegado el proyecto hasta aquí. `git log --oneline` debería poder leerse como una lista de cambios con sentido:

```text
679f7c4 Enlaza vacaciones desde el README y las normas de trabajo
d3d74cb Añade la página de vacaciones
cb850fa Añade pipeline de validación
6635980 Añade normas de trabajo y scripts de validación
066adcb Añade bienvenida y herramientas
f3089be Crea el manual del equipo
```

| Recomendación | En el proyecto | Qué evita |
|---------------|--------------|-----------|
| **Commits pequeños**, una idea cada uno | Un commit crea la página; otro añade los enlaces | Commits que mezclan tres cosas y no se pueden revisar ni deshacer por separado |
| **Mensajes que digan qué y para qué**, en imperativo | «Añade la página de vacaciones», no «cambios» ni «wip» | Tener que abrir el diff para saber qué hizo un commit |
| **Ramas cortas** con nombre que remite a la issue | `1-pagina-de-vacaciones` | Ramas que viven semanas, se alejan de `main` y acaban en conflicto |
| **MR pequeñas**, una tarea por MR | La MR solo trae la página de vacaciones y sus enlaces | Revisiones eternas que nadie lee entera |
| **`Closes #n`** en la descripción de la MR | `Closes #1` | Issues abiertas de trabajo que ya está hecho |
| **Borrar la rama al fusionar** | Opción **Delete source branch** marcada en la MR | Una lista de ramas en la que no se sabe cuál sigue viva |
| **`git pull` en `main` antes de empezar** | `git switch main` y `git pull` antes de `git switch -c` | Partir de una versión vieja del proyecto y chocar con lo que ya se fusionó |

> [!NOTE]
> Al fusionar, GitLab crea por defecto un commit de merge («Merge branch '1-pagina-de-vacaciones' into 'main'») que agrupa los commits de la rama. En `git log --oneline --graph` se ve la rama que salió de `main` y volvió a entrar: el historial cuenta también cómo se integró cada tarea.

> [!TIP]
> Revisa tus commits antes del push con `git log --oneline origin/main..HEAD`: lista solo los que todavía no están en GitLab. Si alguno no se entiende por su mensaje, tampoco lo entenderá quien revise la MR.

## Errores habituales y cómo evitarlos

| Error | Cómo se nota | Cómo evitarlo o arreglarlo |
|-------|--------------|----------------------------|
| Commit sin push | En GitLab no aparece el cambio; `git status` dice `Your branch is ahead of 'origin/main' by 1 commit.` | `git commit` es local: termina con `git push` y comprueba la rama en **Code → Branches** |
| Trabajar directamente en `main` | El push falla con `remote: GitLab: You are not allowed to push code to protected branches on this project.` | Antes de editar, `git switch -c <n>-<tarea>`. Si ya hiciste el commit en `main`, crea la rama ahí mismo (`git switch -c …`) y publica esa rama |
| `git add .` con basura | En la MR aparecen `public/`, copias de seguridad o archivos del editor | Mira `git status` antes de `git add`, añade por nombre y pon en `.gitignore` lo generado |
| Mensajes vacíos o sin contenido | `Aborting commit due to empty commit message.`, o un log lleno de «cambios», «arreglo», «wip» | Un mensaje que diga qué hace el commit, en imperativo: «Corrige el enlace a vacaciones» |
| Conflicto por rama vieja | La MR avisa de que hay conflictos con `main` y no deja fusionar | `git pull` en `main` antes de crear la rama y ramas que duren poco. Si ya pasó, trae `main` a tu rama, resuelve y vuelve a hacer push |
| Pipeline rojo ignorado | La MR muestra el pipeline **failed** y alguien fusiona igual | Abre el job que falla y lee su log: `validar.sh` dice qué archivo y qué falta. Arregla con un commit nuevo en la misma rama |
| MR sin `Closes #n` | La tarea está en `main` pero la issue sigue **Open** | Escribe `Closes #n` en la descripción al crear la MR, o edítala antes de fusionar |
| Rama fusionada que no se borra | **Code → Branches** se llena de ramas ya integradas | Deja marcada **Delete source branch** y, en local, `git branch -d <rama>` tras el `git pull` |
| Clave SSH privada fuera de su ordenador | Alguien copia `~/.ssh/id_ed25519` (la que no acaba en `.pub`) a un chat, a otro equipo o al repositorio | La privada no sale nunca del ordenador; a GitLab solo se le da la `.pub`. Si se ha expuesto, bórrala en **Edit profile → SSH keys** y genera otra |
| Token o contraseña en un fichero del repositorio | El secreto aparece en un commit, visible en GitLab para todos los miembros | No escribas secretos en archivos versionados. Borrarlo en un commit nuevo no basta: sigue en el historial. Revoca el token en GitLab y crea otro |

> [!WARNING]
> Un secreto que ha llegado a un commit publicado hay que darlo por comprometido. Lo que lo arregla es revocarlo en GitLab (**Edit profile → Access tokens** para un token, **Edit profile → SSH keys** para una clave), no borrar la línea.

El laboratorio de este módulo, [Lab — Flujo completo](01-lab-flujo-completo.md), recorre una tarea entera del proyecto con `main` protegida y el pipeline activo, desde la issue hasta el `git pull` final.
