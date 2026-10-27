# Lab — Release

[← Página anterior](01-lab-imagen.md)

`latest` se mueve: el próximo push la sustituye. Una versión tiene nombre y se queda. En este lab etiquetas el commit como `v1.0.0` y el pipeline publica la imagen con ese nombre y crea la release en GitLab.

### Objetivo

Dejar en `ana/manual-m07-release` la release `manual-equipo v1.0.0`, creada por el pipeline del tag, y ejecutar la imagen `gitlab:5050/ana/manual-m07-release:v1.0.0`.

### Punto de partida

- El entorno de prácticas levantado ([El entorno de prácticas](../../infra/README.md)): GitLab en `http://localhost:8080`, registro en `gitlab:5050` y su runner. Cuenta `ana`, contraseña `Formacion-2026!`.
- Estado: en el terminal del Codespace, ejecuta:

  ```bash
  # 🖥️ Terminal del Codespace
  scripts/partida.sh ana manual-m07-release --con-imagen
  docker exec -it pc-ana bash
  ```

  Crea `ana/manual-m07-release` con el `Dockerfile` y un `.gitlab-ci.yml` que ya publica la imagen `:latest`. Lo clona en `~/trabajo/manual-m07-release` del ordenador de Ana y lanza el pipeline de `main`. El segundo comando te sienta en el ordenador de Ana.

### En qué consiste

Lees el job que ya sube `:latest`, lo amplías para que en un tag suba también `v1.0.0`, y añades el job que crea la release. Luego publicas el tag. No cambias el `Dockerfile` ni los scripts.

### 1 — Lee el job que ya publica

**Acción** (📝 VS Code, ordenador de Ana): abre `home-ana/trabajo/manual-m07-release/.gitlab-ci.yml`.

**Por qué:** el punto de partida ya sube una imagen en cada pipeline. La versión es un añadido sobre ese job, más otro job que solo entra cuando hay tag.

**Resultado esperado:** hay una stage `publicar` y el job `publicar-imagen` hace `docker build`, etiqueta `$CI_REGISTRY_IMAGE:latest` y hace `docker push` de ese tag. No hay stage `version` ni job `publicar-release`.

### 2 — Deja el pipeline de la versión

**Acción** (📝 VS Code, ordenador de Ana): sustituye `.gitlab-ci.yml` por este contenido y guarda:

```yaml
stages:
  - validar
  - construir
  - publicar
  - version

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

publicar-imagen:
  stage: publicar
  image:
    name: docker:27-cli
    entrypoint: [""]
  script:
    - docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" "$CI_REGISTRY"
    - docker build -t "$CI_REGISTRY_IMAGE:latest" .
    - docker push "$CI_REGISTRY_IMAGE:latest"
    - |
      if [ -n "$CI_COMMIT_TAG" ]; then
        docker tag "$CI_REGISTRY_IMAGE:latest" "$CI_REGISTRY_IMAGE:$CI_COMMIT_TAG"
        docker push "$CI_REGISTRY_IMAGE:$CI_COMMIT_TAG"
      fi

publicar-release:
  stage: version
  image: alpine:3.20
  rules:
    - if: $CI_COMMIT_TAG
  script:
    - apk add --no-cache curl
    - |
      curl --fail-with-body --silent --show-error \
        --header "JOB-TOKEN: ${CI_JOB_TOKEN}" \
        --data-urlencode "name=manual-equipo ${CI_COMMIT_TAG}" \
        --data-urlencode "tag_name=${CI_COMMIT_TAG}" \
        --data-urlencode "description=Imagen del proyecto ${CI_REGISTRY_IMAGE}:${CI_COMMIT_TAG}" \
        "http://gitlab:8080/api/v4/projects/${CI_PROJECT_ID}/releases"
```

**Por qué:** hay dos añadidos. El `if` etiqueta la imagen con el nombre del tag de Git solo cuando el pipeline es de un tag (`CI_COMMIT_TAG` vale `v1.0.0`; en un push a `main` está vacía). El job `publicar-release` tiene `rules: if: $CI_COMMIT_TAG`, así que GitLab lo incluye en el pipeline del tag y lo deja fuera del de `main`. Llama a la API en `http://gitlab:8080` —el nombre del servidor dentro de la red— con el token del job, y GitLab abre la ficha sobre el tag que ya existe. El job no crea el tag.

**Resultado esperado:** `git status --short` muestra `M .gitlab-ci.yml`. La lista `stages` termina en `version`.

### 3 — Registra el pipeline nuevo en `main`

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
cd ~/trabajo/manual-m07-release
git add .gitlab-ci.yml
git commit -m "Crea la release al etiquetar una versión"
git push
```

**Por qué:** este push es a la rama `main`. Sirve para dejar el archivo en el repositorio. La release todavía no existe: este pipeline no es de un tag.

**Resultado esperado:** el push termina en `main -> main`.

### 4 — Comprueba que `main` no crea la release

**Acción** (🌐 GitLab, sesión de Ana): abre **Build → Pipelines** y entra en el pipeline del commit «Crea la release al etiquetar una versión».

**Por qué:** la regla `if: $CI_COMMIT_TAG` no se cumple en una rama. El job no sale como fallido ni como **Skipped**: no forma parte de este pipeline.

**Resultado esperado:** el grafo tiene tres columnas, `validar`, `construir` y `publicar`. No aparece `publicar-release`. **Deploy → Releases** sigue vacío.

> [!TIP]
> Si el pipeline de partida (el del commit «Publica la imagen del proyecto») todavía está en **Running**, no importa: el que cuenta para este paso es el del commit que acabas de subir.

### 5 — Crea el tag y publícalo

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
git status
git tag v1.0.0
git push origin v1.0.0
```

**Por qué:** `git tag v1.0.0` pone el nombre en el commit en el que estás, el de `main` con el pipeline de la versión ya commiteado. `git push origin v1.0.0` sube el tag, no la rama. GitLab arranca un pipeline distinto, el del tag.

**Resultado esperado:** `git status` dice `On branch main` y `nothing to commit, working tree clean`. El push del tag termina en:

```text
* [new tag]         v1.0.0 -> v1.0.0
```

> [!WARNING]
> `git push` sin el nombre del tag sube la rama y no crea el pipeline de la versión. El comando que lo sube es `git push origin v1.0.0`.

### 6 — Abre el pipeline del tag

**Acción** (🌐 GitLab, sesión de Ana): en **Build → Pipelines**, abre la fila cuyo ref es el tag `v1.0.0` (no la de la rama `main`).

**Por qué:** es otro pipeline, sobre el mismo commit, con la variable `CI_COMMIT_TAG` rellena. Por eso entran el `if` del job de la imagen y el job de la release.

**Resultado esperado:** cuatro columnas: `validar`, `construir`, `publicar` y `version`. `publicar-imagen` y `publicar-release` terminan en **Passed**.

> 📷 **Captura pendiente** · `M07-02-pipeline-tag.png` — pipeline del tag v1.0.0 con la stage version en Passed

### 7 — Lee la ficha en el log

**Acción** (🌐 GitLab, sesión de Ana): abre el job `publicar-release` y mira el final del log.

**Por qué:** el cuerpo de la respuesta es la release que GitLab acaba de crear. Si el tag no existiera, o la release ya estuviera creada, el `curl` fallaría y el job no quedaría en **Passed**.

**Resultado esperado:** un JSON con `"tag_name":"v1.0.0"` y `"name":"manual-equipo v1.0.0"`. La descripción contiene `gitlab:5050/ana/manual-m07-release:v1.0.0`. El log acaba en `Job succeeded`.

### 8 — Abre la release

**Acción** (🌐 GitLab, sesión de Ana): en la barra lateral, abre **Deploy → Releases**.

**Por qué:** es la página que ve el equipo. El log solo lo mira quien revisa el pipeline.

**Resultado esperado:** una release con título `manual-equipo v1.0.0`, tag `v1.0.0` y la descripción `Imagen del proyecto gitlab:5050/ana/manual-m07-release:v1.0.0`.

> 📷 **Captura pendiente** · `M07-02-release.png` — Deploy → Releases con manual-equipo v1.0.0

### 9 — Ejecuta la imagen de esa versión

**Acción** (🖥️ Terminal del Codespace):

```bash
# 🖥️ Terminal del Codespace
docker login gitlab:5050 -u ana -p 'Formacion-2026!'
docker run --rm gitlab:5050/ana/manual-m07-release:v1.0.0 | head -n 1
```

**Por qué:** `v1.0.0` no se mueve cuando alguien vuelva a publicar `:latest`. Esta ejecución es la de la release, no la del último push a `main`.

**Resultado esperado:** `Login Succeeded` si aún no habías entrado, y la primera línea del documento:

```text
# Manual del equipo
```

En **Deploy → Container Registry** están los dos tags, `latest` y `v1.0.0`.

> 📷 **Captura pendiente** · `M07-02-registry.png` — tags latest y v1.0.0 en Container Registry

## Comprueba tu entendimiento

**El tag está en el commit de la release**
En el ordenador de Ana, `git log -1 --oneline` y `git log -1 --oneline v1.0.0`.
→ Los dos muestran el mismo commit, «Crea la release al etiquetar una versión».

**Un push a `main` no abre otra release**
En **Deploy → Releases**, cuenta las entradas.
→ Hay una. El pipeline de `main` del paso 4 no ha creado ninguna.

## Reto

### 1 — Otra versión, otro texto

Publica `v1.0.1`. En la descripción de esa release tiene que leerse la frase `Incluye la bienvenida, las herramientas y las normas.`

<details>
<summary>Ver solución</summary>

En el `curl` del job `publicar-release`, cambia el `--data-urlencode` de `description` a:

```yaml
        --data-urlencode "description=Incluye la bienvenida, las herramientas y las normas. Imagen ${CI_REGISTRY_IMAGE}:${CI_COMMIT_TAG}"
```

Commit y push a `main`. Cuando ese pipeline esté en **Passed**:

```bash
# 💻 Ordenador de Ana
git tag v1.0.1
git push origin v1.0.1
```

En **Deploy → Releases** aparece `manual-equipo v1.0.1` con esa frase. `v1.0.0` sigue en la lista, con su descripción anterior.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| El pipeline de `main` no muestra `publicar-release` | La regla se cumple solo en un tag. En `main` es lo esperado | Sigue en el paso 5 y abre el pipeline cuya ref es `v1.0.0` |
| `git push` sube `main` y no aparece un pipeline de tag | Falta el nombre del tag en el push | `git push origin v1.0.0` |
| El pipeline del tag no arranca | El tag se ha creado en local y no se ha subido | `git ls-remote --tags origin` tiene que listar `v1.0.0`. Si no está, `git push origin v1.0.0` |
| `publicar-release` falla con `tag_name is already taken` o `Release already exists` | Ese tag ya tiene release, de un intento anterior | Usa otro nombre, como en el reto (`v1.0.1`), o borra la release en **Deploy → Releases** y vuelve a lanzar el pipeline del tag |
| El `curl` no conecta con `localhost` | Dentro del job `localhost` es el contenedor del job, no GitLab | La URL del job es `http://gitlab:8080/api/v4/...` |
| La imagen `:v1.0.0` no está en el registro y `:latest` sí | El `if` de `CI_COMMIT_TAG` no está en `publicar-imagen`, o el pipeline que miras es el de `main` | Compara el `script` con el del paso 2 y abre el pipeline del tag |
| `error: src refspec v1.0.0 matches more than one` | Hay una rama y un tag con el mismo nombre | En este lab la rama es `main`. Borra el tag local mal puesto con `git tag -d v1.0.0` y créalo de nuevo estando en `main` |
