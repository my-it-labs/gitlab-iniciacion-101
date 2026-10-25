# Pipelines, stages y jobs

[← Página anterior](README.md) · [Siguiente página →](01-lab-primer-pipeline.md)

El manual del equipo ya se mantiene con ramas y merge requests, pero nadie comprueba si una página ha perdido el título o si un enlace apunta a una página que no existe. Esta demostración recorre el pipeline de `manual-equipo`: el archivo que lo describe, cómo arranca solo tras un push y dónde se lee lo que ha pasado.

## Punto de partida

- URL: `https://gitlab.ejemplo.com/ana/manual-m05-demo` (la URL real de la instancia la da el formador).
- Identidad: usuaria `ana`, con su token de acceso personal como contraseña al hacer push.
- Estado: proyecto creado desde el repositorio del curso con `scripts/partida.sh manual-m05-demo --con-ci`. Tiene el manual, los scripts `scripts/validar.sh` y `scripts/construir.sh`, y el `.gitlab-ci.yml` en el 4.º commit, «Añade pipeline de validación». Copia local en `~/trabajo/manual-m05-demo`.

## Recorrido

### El archivo `.gitlab-ci.yml`

1. En la raíz del repositorio está `.gitlab-ci.yml`. GitLab lo busca ahí, con ese nombre exacto, y si lo encuentra lanza un pipeline en cada push:

```yaml
stages:
  - validar
  - construir

validar-paginas:
  stage: validar
  image: alpine:3.20
  script:
    - sh scripts/validar.sh

construir-manual:
  stage: construir
  image: alpine:3.20
  script:
    - sh scripts/construir.sh
  artifacts:
    paths:
      - public/
    expire_in: 1 week
```

2. El archivo se lee en dos partes:

| Parte | Qué dice en este proyecto |
|-------|---------------------------|
| `stages:` | Hay dos fases y en este orden: primero `validar`, después `construir` |
| `validar-paginas:` | Un job de la fase `validar`. En un contenedor `alpine:3.20` ejecuta `sh scripts/validar.sh` |
| `construir-manual:` | Un job de la fase `construir`. Ejecuta `sh scripts/construir.sh` y guarda la carpeta `public/` como artefacto |

Cualquier clave de primer nivel que no sea una palabra reservada (`stages`, `default`, `variables`…) es un job, y su nombre es el que aparecerá en GitLab. Los comandos de `script` son los mismos que se pueden ejecutar en el propio equipo: el pipeline no hace nada que no haga `sh scripts/validar.sh` en la terminal.

> [!NOTE]
> **Integración continua** es esto: cada cambio publicado se comprueba solo, con las mismas reglas para todo el equipo. La **entrega continua** sería el paso siguiente: dejar listo lo que se publica. Aquí llega hasta generar el manual completo (`public/manual-completo.md`); desplegarlo no entra en el curso.

### Del push al pipeline

3. En la copia local se cambia una línea de `docs/normas-de-trabajo.md` y se publica con `git commit -am "Ajusta la hora de la reunión de equipo"` y `git push`. El push no menciona el pipeline: Git solo sube los commits. Es GitLab quien, al recibirlos, ve el `.gitlab-ci.yml` y crea el pipeline.

4. En la barra lateral del proyecto, **Build → Pipelines** muestra la lista de ejecuciones. La más reciente aparece arriba, con su estado (**Running** mientras dura, **Passed** al acabar bien), el número de pipeline, la rama `main`, el commit que lo ha lanzado y una fila de iconos, uno por stage.

5. Al abrir el pipeline (clic en su estado o en su número), la pestaña de grafo dibuja una columna por stage: `validar` con el job `validar-paginas` y `construir` con `construir-manual`. La columna `construir` no empieza hasta que todos los jobs de `validar` han terminado bien. Si la validación fallara, `construir-manual` quedaría en **Skipped**: no tiene sentido generar un manual con páginas rotas.

### El runner y el log del job

6. Al hacer clic en `validar-paginas` se abre la página del job con su log. Las primeras líneas dicen quién lo ha ejecutado y dónde:

```text
Running with gitlab-runner 19.4.1 (3c39fceb)
  on 632e8b5990f4 X4YQlJFX2, system ID: r_AEBhsLF3aeFA
  UUID: 01a1695d-ff1e-76f4-8222-da7d3268b956
Preparing the "docker" executor
Using Docker executor with image alpine:3.20 ...
```

El **runner** es el proceso que recoge el job de la cola de GitLab y lo ejecuta. Este usa el *executor* Docker: arranca un contenedor nuevo con la imagen `alpine:3.20` que pide el job, y al terminar lo descarta. El runner lo aporta la instancia del curso; GitLab solo coordina.

7. Siguen unas líneas de preparación (descarga de imágenes, clonado del repositorio). La más útil es la que indica qué commit se ha comprobado:

```text
Getting source from Git repository
Fetching changes with git depth set to 20...
Initialized empty Git repository in /builds/alumno1/manual-prueba/.git/
Created fresh repository.
Checking out 1bdf75a6 as detached HEAD (ref is main)...
```

8. Después viene la parte que importa: cada comando de `script` aparece precedido de `$`, seguido de lo que ha escrito. El log termina con el resultado del job:

```text
Executing "step_script" stage of the job script
$ sh scripts/validar.sh
revisado README.md
revisado docs/bienvenida.md
revisado docs/herramientas.md
revisado docs/normas-de-trabajo.md
Todas las páginas son correctas
Cleaning up project directory and file based variables
Job succeeded
```

(Log real de la instancia de pruebas, con las líneas de descarga de imágenes recortadas; el proyecto de esa prueba se llamaba `alumno1/manual-prueba`.)

Es exactamente la salida de `sh scripts/validar.sh` en local. Un job acaba en **Passed** si su último comando termina con código 0; si cualquier comando devuelve otro código, el job falla y el log acaba en `ERROR: Job failed: exit code 1`.

9. El job `construir-manual` deja en su log la línea `Generado public/manual-completo.md (65 líneas)` y, al final, la subida del artefacto:

```text
$ sh scripts/construir.sh
Generado public/manual-completo.md (65 líneas)
Uploading artifacts for successful job
Uploading artifacts...
public/: found 2 matching artifact files and directories 
Uploading artifacts as "archive" to coordinator... 201 Created  correlation_id=01M5MNWTY6C01W473C0W0TNKEG id=2 status=201 token=64_HpuqoY
Cleaning up project directory and file based variables
Job succeeded
```

En la página de ese job, el panel lateral **Job artifacts** ofrece descargar o explorar `public/`.

## Qué queda visto

- `.gitlab-ci.yml` declara las stages y los jobs; cada job dice en qué stage va, qué imagen usa y qué comandos ejecuta.
- Un push a `main` basta para que el pipeline arranque, sin pulsar nada.
- El pipeline se ve en **Build → Pipelines**; las stages se ejecutan en orden y una stage fallida deja las siguientes en **Skipped**.
- El job lo ejecuta un runner en un contenedor; su log muestra cada comando tras `$` y termina en `Job succeeded` o en `ERROR: Job failed`.

Cada pieza se practica por separado: escribir el primer pipeline en [01 — Lab — Primer pipeline](01-lab-primer-pipeline.md), descargar el artefacto en [02 — Lab — Artefacto](02-lab-artefacto.md) y diagnosticar un fallo por el log en [03 — Lab — Fallo controlado](03-lab-fallo-controlado.md). Ninguno necesita haber visto esta demostración.
