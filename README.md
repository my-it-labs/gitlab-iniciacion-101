# GitLab — Iniciación

[Siguiente página →](labs/M01-introduccion-git-gitlab/00-control-de-versiones.md)

## De qué va este curso

Este curso es para ti si nunca has usado Git o lo has usado sin entender lo que pasaba. Da igual que programes, pruebes, documentes u operes sistemas: no necesitas saber programar.

Tu equipo mantiene **`manual-equipo`**, el manual interno con el que se incorpora la gente nueva: unas cuantas páginas en Markdown. Hasta ahora se editaba a mano en una carpeta compartida. Nadie sabía quién había cambiado qué, a veces se pisaban los cambios y una página rota pasaba días sin que nadie la viera.

En este curso vas a llevar ese manual a Git y GitLab. Primero lo guardas con historial. Después trabajas cada cambio en su rama y lo integras con una merge request que revisa un compañero. Al final, un pipeline lo comprueba antes de fusionarlo. Como es texto y no código, cada diff y cada conflicto se lee a simple vista. Así te centras en Git y GitLab, no en un lenguaje.

Al terminar sabrás crear y usar repositorios locales y remotos, registrar cambios y consultar su historial, trabajar con ramas y resolver conflictos sencillos, colaborar con issues y merge requests y ejecutar un pipeline básico de GitLab CI/CD. Además, harás tú solo el recorrido completo, desde la issue hasta la fusión.

## Temario

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

## Antes de empezar

| Requisito | Dónde |
|-----------|-------|
| Navegador, Git y Visual Studio Code | Se comprueba en el M01 |
| Cuenta en la instancia de GitLab del curso, con permiso para crear proyectos | Te la da el formador |
| Runner disponible para CI/CD | Lo aporta la instancia del curso; se usa en el M05 |

## Empieza aquí

→ **[M01 — Control de versiones y las tres áreas](labs/M01-introduccion-git-gitlab/00-control-de-versiones.md)**
