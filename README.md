# GitLab — Iniciación

[Siguiente página →](labs/M01-introduccion-git-gitlab/README.md)

## De qué va este curso

Tu equipo mantiene **`manual-equipo`**, el manual interno con el que se incorpora la gente nueva: unas cuantas páginas en Markdown. Hasta ahora se editaba a mano en una carpeta compartida. Nadie sabía quién había cambiado qué, a veces se pisaban los cambios y una página rota pasaba días sin que nadie la viera.

En este curso vas a llevar ese manual a Git y GitLab. Primero lo guardas con historial. Después trabajas cada cambio en su rama y lo integras con una merge request que revisa un compañero. Al final, un pipeline lo comprueba antes de fusionarlo. Es texto y no código, así que no necesitas saber programar: cada diff y cada conflicto se lee a simple vista.

Al terminar sabrás registrar cambios y consultar su historial, trabajar con ramas y resolver conflictos sencillos, colaborar con issues y merge requests y entender y ejecutar un pipeline básico de GitLab CI/CD. Además, harás tú solo el recorrido completo, desde la issue hasta la fusión.

## Temario

- **M01 — Introducción a Git y GitLab** — [qué es el control de versiones, las tres áreas de Git y tu primer proyecto en GitLab](labs/M01-introduccion-git-gitlab/README.md)
- **M02 — Operaciones básicas con repositorios** — [clonar, registrar cambios, consultar historial y diferencias, sincronizar con GitLab y excluir archivos](labs/M02-operaciones-basicas/README.md)
- **M03 — Ramas, fusiones y resolución de conflictos** — [cambios aislados en una rama, fusión con merge y el conflicto que aparece al tocar las mismas líneas](labs/M03-ramas-y-conflictos/README.md)
- **M04 — Trabajo colaborativo en GitLab** — [miembros y roles, issues, merge requests revisadas y la rama principal protegida](labs/M04-trabajo-colaborativo/README.md)
- **M05 — Introducción a GitLab CI/CD** — [un pipeline que valida el manual en cada push, sus logs, sus artefactos y cómo diagnosticar un fallo](labs/M05-gitlab-ci-cd/README.md)
- **M06 — Ejercicio integrador y buenas prácticas** — [una tarea de la issue a la fusión, con un historial claro y sin los errores habituales](labs/M06-flujo-completo/README.md)

## Antes de empezar

| Requisito | Dónde |
|-----------|-------|
| Navegador, Git y Visual Studio Code | Se comprueba en el M01 |
| Cuenta en la instancia de GitLab del curso, con permiso para crear proyectos | Te la da el formador |
| Runner disponible para CI/CD | Lo aporta la instancia del curso; se usa en el M05 |

## Empieza aquí

→ **[M01 — Introducción a Git y GitLab](labs/M01-introduccion-git-gitlab/README.md)**
