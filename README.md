# GitLab — Iniciación

[Siguiente página →](labs/M01-introduccion-git-gitlab/00-control-de-versiones.md)

## Objetivo general

Al finalizar el curso, el alumno registra y comparte su trabajo con Git y GitLab: guarda cada cambio con su historial, lo desarrolla en una rama, lo integra mediante una merge request revisada y lo valida con un pipeline de GitLab CI/CD.

## Enfoque

Todo el curso trabaja sobre un único proyecto, `manual-equipo`: la documentación interna de un equipo, su manual, con páginas en Markdown sobre la bienvenida a quien se incorpora, las herramientas y las normas de trabajo, y dos scripts que comprueban que las páginas están bien. En las prácticas se le llama simplemente **el proyecto**. Al ser texto y no código, cada diff y cada conflicto se leen a simple vista, y la atención queda en Git y GitLab, no en un lenguaje de programación. El recorrido va del primer commit en local a la sincronización con GitLab, a las ramas y sus conflictos, al trabajo entre dos personas del equipo, Ana y Luis, con issues y merge requests sobre una rama protegida y al pipeline que comprueba cada push. Cada tema se cierra con el cambio publicado en GitLab, donde se puede ver y explicar qué ha ocurrido.

## Dirigido a

Personas que empiezan con el control de versiones o que han usado Git sin entender lo que pasaba, y que van a trabajar en proyectos alojados en GitLab: desarrollo, pruebas, documentación u operaciones.

## Conocimientos previos

Manejo básico del ordenador, de un editor de texto y de la terminal (abrir una carpeta y ejecutar un comando). No hace falta saber programar ni haber usado Git. Las ramas, las merge requests y CI/CD se estudian en el curso. Todo el entorno (GitLab, su runner y los ordenadores del equipo) se levanta en tu Codespace, por lo que no hace falta instalar nada ni crear cuentas en otros servicios.

## Objetivos específicos

- Explicar para qué sirve el control de versiones, qué hace Git y qué añade GitLab, y seguir un cambio por el directorio de trabajo, el área de preparación y el commit.
- Clonar un repositorio, registrar cambios en commits, consultar su historial y sus diferencias, sincronizarlo con GitLab y excluir archivos con `.gitignore`.
- Desarrollar un cambio aislado en una rama, fusionarlo con `merge` y resolver un conflicto sencillo.
- Colaborar en un proyecto compartido: roles, issues, merge requests revisadas y rama principal protegida.
- Escribir un `.gitlab-ci.yml` básico, interpretar su pipeline, leer el log de un job que falla y descargar su artefacto.
- Completar una tarea desde la issue hasta la fusión con un historial claro.

## Temario

<!-- gen:temario -->
- **[M01 — Introducción a Git y GitLab](labs/M01-introduccion-git-gitlab/README.md)**
  - [Control de versiones: utilidad y conceptos fundamentales](labs/M01-introduccion-git-gitlab/00-control-de-versiones.md)
  - [Diferencias entre Git y GitLab](labs/M01-introduccion-git-gitlab/00-control-de-versiones.md)
  - [Repositorio, directorio de trabajo, área de preparación y commit](labs/M01-introduccion-git-gitlab/00-control-de-versiones.md)
  - [Navegación por GitLab: proyectos, repositorios y principales funcionalidades](labs/M01-introduccion-git-gitlab/02-lab-primer-proyecto.md)
  - [Configuración inicial de Git e identificación del usuario](labs/M01-introduccion-git-gitlab/01-lab-identidad-y-acceso.md)
- **[M02 — Operaciones básicas con repositorios](labs/M02-operaciones-basicas/README.md)**
  - [Creación y clonación de repositorios](labs/M02-operaciones-basicas/01-lab-clonar.md)
  - [Consulta del estado de los archivos](labs/M02-operaciones-basicas/01-lab-clonar.md)
  - [Preparación y registro de cambios: status, add y commit](labs/M02-operaciones-basicas/02-lab-commits.md)
  - [Consulta del historial y comparación de cambios: log y diff](labs/M02-operaciones-basicas/03-lab-publicar-y-comparar.md)
  - [Sincronización con GitLab: push, pull y conceptos básicos de fetch](labs/M02-operaciones-basicas/03-lab-publicar-y-comparar.md)
  - [Exclusión de archivos mediante .gitignore](labs/M02-operaciones-basicas/04-lab-gitignore.md)
- **[M03 — Ramas, fusiones y resolución de conflictos](labs/M03-ramas-y-conflictos/README.md)**
  - [Propósito de las ramas en el trabajo diario](labs/M03-ramas-y-conflictos/00-ramas-como-punteros.md)
  - [Creación, cambio y eliminación de ramas](labs/M03-ramas-y-conflictos/01-lab-rama-y-merge.md)
  - [Desarrollo de cambios aislados](labs/M03-ramas-y-conflictos/01-lab-rama-y-merge.md)
  - [Fusión de ramas mediante merge](labs/M03-ramas-y-conflictos/01-lab-rama-y-merge.md)
  - [Origen y resolución de conflictos](labs/M03-ramas-y-conflictos/02-lab-conflicto.md)
  - [Buenas prácticas para commits y nombres de ramas](labs/M03-ramas-y-conflictos/03-buenas-practicas.md)
- **[M04 — Trabajo colaborativo en GitLab](labs/M04-trabajo-colaborativo/README.md)**
  - [Miembros del proyecto y roles básicos](labs/M04-trabajo-colaborativo/01-lab-proyecto-compartido.md)
  - [Issues para registrar tareas e incidencias](labs/M04-trabajo-colaborativo/02-lab-de-issue-a-mr.md)
  - [Merge requests: creación, revisión y fusión](labs/M04-trabajo-colaborativo/03-lab-revision.md)
  - [Comentarios y propuestas de modificación](labs/M04-trabajo-colaborativo/03-lab-revision.md)
  - [Relación entre issues, ramas y merge requests](labs/M04-trabajo-colaborativo/02-lab-de-issue-a-mr.md)
  - [Protección de la rama principal](labs/M04-trabajo-colaborativo/01-lab-proyecto-compartido.md)
- **[M05 — Introducción a GitLab CI/CD](labs/M05-gitlab-ci-cd/README.md)**
  - [Conceptos de integración y entrega continuas](labs/M05-gitlab-ci-cd/00-pipelines-stages-jobs.md)
  - [Estructura básica del archivo .gitlab-ci.yml](labs/M05-gitlab-ci-cd/01-lab-primer-pipeline.md)
  - [Pipelines, stages y jobs](labs/M05-gitlab-ci-cd/00-pipelines-stages-jobs.md)
  - [Función de los runners](labs/M05-gitlab-ci-cd/00-pipelines-stages-jobs.md)
  - [Ejecución automática tras publicar cambios](labs/M05-gitlab-ci-cd/01-lab-primer-pipeline.md)
  - [Consulta de logs y diagnóstico de errores sencillos](labs/M05-gitlab-ci-cd/03-lab-fallo-controlado.md)
  - [Introducción a los artefactos de un job](labs/M05-gitlab-ci-cd/02-lab-artefacto.md)
- **[M06 — Ejercicio integrador y buenas prácticas](labs/M06-flujo-completo/README.md)**
  - [Repaso del flujo completo de trabajo](labs/M06-flujo-completo/01-lab-flujo-completo.md)
  - [Organización básica del repositorio y documentación](labs/M06-flujo-completo/00-flujo-completo.md)
  - [Recomendaciones para colaborar y mantener un historial claro](labs/M06-flujo-completo/00-flujo-completo.md)
  - [Errores habituales y cómo evitarlos](labs/M06-flujo-completo/00-flujo-completo.md)
<!-- /gen:temario -->

## Antes de empezar

Las prácticas se hacen en un equipo simulado dentro de tu Codespace: un GitLab con su runner y un ordenador (un contenedor Ubuntu) para cada miembro del equipo, Ana y Luis. Haces de los dos: editas los archivos de cada uno con VS Code, usas Git en su ordenador y entras en GitLab con su sesión. Cada paso dice dónde se hace:

| Marca | Dónde estás |
|-------|-------------|
| 🖥️ Terminal del Codespace | Tu terminal: levantar el entorno, preparar una página y entrar en un ordenador |
| 💻 Ordenador de Ana · 💻 Ordenador de Luis | La terminal de su ordenador, solo para Git; el prompt lo confirma: `ana@pc-ana:~$` |
| 📝 VS Code, ordenador de Ana · de Luis | Sus archivos, en las carpetas `home-ana/` y `home-luis/` del explorador de VS Code |
| 🌐 GitLab, sesión de Ana · sesión de Luis | El navegador, con la cuenta de esa persona |

Cómo se levanta y cómo se entra en cada sitio: **[El entorno de prácticas](infra/README.md)**.

Cada laboratorio empieza desde cero con su propia copia del proyecto: `scripts/partida.sh` la crea en GitLab y la clona en el ordenador de quien lo va a usar. Cada página indica el comando exacto.

## Empieza aquí

<!-- gen:empieza -->
→ **[M01 — Control de versiones y las tres áreas](labs/M01-introduccion-git-gitlab/00-control-de-versiones.md)**
<!-- /gen:empieza -->
