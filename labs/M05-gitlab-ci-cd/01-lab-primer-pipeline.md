# Lab — Primer pipeline

[← Página anterior](00-pipelines-stages-jobs.md) · [Siguiente página →](02-lab-artefacto.md)

En `manual-equipo` existe `scripts/validar.sh`, que comprueba que cada página tiene título y que los enlaces entre páginas funcionan. Pero solo sirve si alguien se acuerda de ejecutarlo. En este lab escribes el `.gitlab-ci.yml` que lo ejecuta en cada push, sin que nadie tenga que acordarse.

### Objetivo

Un proyecto con un `.gitlab-ci.yml` de un stage (`validar`) y un job (`validar-paginas`), y un pipeline en **Passed** lanzado por tu push.

### Punto de partida

- El entorno de prácticas levantado ([El entorno de prácticas](../../infra/README.md)): GitLab en `http://localhost:8080` y su runner.
- Estado: en el terminal del Codespace, ejecuta:

  ```bash
  # 🖥️ Terminal del Codespace
  scripts/partida.sh ana manual-m05-pipeline
  docker exec -it pc-ana bash
  ```

  Crea `ana/manual-m05-pipeline` en GitLab con el contenido del proyecto y tres commits, **sin** `.gitlab-ci.yml`, y lo clona en `~/trabajo/manual-m05-pipeline` del ordenador de Ana, con su identidad de Git y su clave SSH. El segundo comando te sienta en su ordenador.

### En qué consiste

Ejecutas la validación en local, creas el `.gitlab-ci.yml` con un solo job, lo publicas y lees el log del pipeline que arranca solo. No tocas las páginas del proyecto ni añades todavía el stage `construir`.

### 1 — Comprueba que el proyecto no tiene pipeline

**Acción** (🌐 GitLab, sesión de Ana): abre `http://localhost:8080/ana/manual-m05-pipeline` y, en la barra lateral, entra en **Build → Pipelines**.

**Por qué:** sin `.gitlab-ci.yml` GitLab no lanza nada al recibir un push. Ver la lista vacía ahora te deja claro qué cambia después.

**Resultado esperado:** la página no muestra ningún pipeline; GitLab ofrece crear uno o abrir el editor de pipelines.

### 2 — Ejecuta la validación en local

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
cd ~/trabajo/manual-m05-pipeline
sh scripts/validar.sh
```

**Por qué:** el pipeline ejecutará exactamente este comando. Si funciona en el ordenador de Ana, sabes qué esperar del log; si falla aquí, fallará también allí.

**Resultado esperado:**

```text
revisado README.md
revisado docs/bienvenida.md
revisado docs/herramientas.md
revisado docs/normas-de-trabajo.md
Todas las páginas son correctas
```

### 3 — Crea el `.gitlab-ci.yml`

**Acción** (📝 VS Code, ordenador de Ana): crea `home-ana/trabajo/manual-m05-pipeline/.gitlab-ci.yml`, en la raíz del proyecto (junto a `README.md`, no dentro de `docs/`), con este contenido, y guarda:

```yaml
stages:
  - validar

validar-paginas:
  stage: validar
  image: alpine:3.20
  script:
    - sh scripts/validar.sh
```

**Por qué:** `stages` declara las fases; `validar-paginas` es el job, el nombre que verás en GitLab. `stage: validar` lo coloca en esa fase, `image` elige el contenedor donde se ejecuta (Alpine trae `sh`, `grep` y `sed`, todo lo que usa el script) y `script` es la lista de comandos.

**Resultado esperado:** el archivo se llama exactamente `.gitlab-ci.yml` (con el punto inicial) y la sangría es de dos espacios, sin tabuladores.

> [!WARNING]
> YAML se rige por la sangría. `stage`, `image` y `script` van dos espacios a la derecha de `validar-paginas:`, y el guion del comando, dos más. Una sangría mal puesta deja el pipeline inválido.

### 4 — Registra el archivo en un commit

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
git add .gitlab-ci.yml
git commit -m "Añade pipeline de validación"
```

**Por qué:** el pipeline forma parte del repositorio: se versiona y se revisa como cualquier página del proyecto.

**Resultado esperado:**

```text
[main 059acc2] Añade pipeline de validación
 1 file changed, 8 insertions(+)
 create mode 100644 .gitlab-ci.yml
```

El identificador del commit será otro.

### 5 — Publica el commit

**Acción** (💻 Ordenador de Ana): `git push`

**Por qué:** el pipeline no lo lanza Ana: lo lanza GitLab al recibir commits en un proyecto que tiene `.gitlab-ci.yml`.

**Resultado esperado:** la salida termina con una línea `main -> main`. No dice nada del pipeline: Git solo sube los commits.

### 6 — Mira el pipeline arrancar

**Acción** (🌐 GitLab, sesión de Ana): vuelve a **Build → Pipelines**.

**Por qué:** es la prueba de que la ejecución es automática: entre el push y esta lista no has pulsado nada.

**Resultado esperado:** un pipeline en la rama `main` con el commit «Añade pipeline de validación». Pasa por **Pending** o **Running** y acaba en **Passed**. Tiene un solo icono de stage.

> 📷 **Captura pendiente** · `M05-01-pipeline-passed.png` — GitLab, sesión de Ana: **Build → Pipelines** con el primer pipeline en **Passed**.

### 7 — Abre el job

**Acción** (🌐 GitLab, sesión de Ana): haz clic en el estado del pipeline y, en el grafo, en el job `validar-paginas`.

**Por qué:** el estado dice si ha ido bien; el log dice qué ha pasado. Saber llegar a él es lo que necesitarás el día que algo falle.

**Resultado esperado:** la página del job con su log y, en el panel lateral, la duración, el runner que lo ejecutó y el commit.

> 📷 **Captura pendiente** · `M05-01-job-log.png` — GitLab, sesión de Ana: el log del job `validar-paginas`.

### 8 — Lee el log

**Acción** (🌐 GitLab, sesión de Ana): recorre el log de arriba abajo y localiza tres cosas: el runner, la imagen y el comando.

**Por qué:** cada bloque del log responde a una pregunta: quién lo ejecuta, en qué contenedor, qué código y qué comandos.

**Resultado esperado:** al principio, el runner y la imagen (los identificadores serán otros):

```text
Running with gitlab-runner 19.4.1 (3c39fceb)
  on 632e8b5990f4 X4YQlJFX2, system ID: r_AEBhsLF3aeFA
Preparing the "docker" executor
Using Docker executor with image alpine:3.20 ...
```

Al final, el comando de tu `script` tras `$`, la misma salida que en el paso 2 y el resultado:

```text
$ sh scripts/validar.sh
revisado README.md
revisado docs/bienvenida.md
revisado docs/herramientas.md
revisado docs/normas-de-trabajo.md
Todas las páginas son correctas
Cleaning up project directory and file based variables
Job succeeded
```

> [!TIP]
> El `.gitlab-ci.yml` también se puede crear desde la web: **Build → Pipeline editor** abre un editor que comprueba la sintaxis mientras escribes y hace el commit al guardar. El resultado es el mismo; si lo usas, haz después `git pull` en el ordenador de Ana para tener el archivo allí.

## Comprueba tu entendimiento

**El pipeline se lanza solo**
En el ordenador de Ana, cambia una línea de `docs/normas-de-trabajo.md` (por ejemplo, la reunión de equipo de las 10:00 a las 10:30), haz commit y `git push`.
→ En **Build → Pipelines** aparece un pipeline nuevo con ese commit, sin haber pulsado nada, y acaba en **Passed**.

**El log es la salida del script**
Compara el bloque tras `$ sh scripts/validar.sh` en el log con lo que imprime `sh scripts/validar.sh` en tu terminal.
→ Son las mismas cinco líneas.

## Reto

### 1 — Un segundo comando en el job

Haz que el job muestre, antes de validar, la lista de páginas de `docs/`. Comprueba en el log que aparece.

<details>
<summary>Ver solución</summary>

Añade un comando a la lista `script`, antes del de validación:

```yaml
  script:
    - ls docs
    - sh scripts/validar.sh
```

Tras el commit y el push, el log muestra `$ ls docs` seguido de `bienvenida.md`, `herramientas.md` y `normas-de-trabajo.md`, y después `$ sh scripts/validar.sh`. Los comandos se ejecutan en orden y, si uno falla, los siguientes no se ejecutan.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| Tras el push no aparece ningún pipeline | El archivo no está en la raíz o el nombre no es exacto (`gitlab-ci.yml` sin punto, `.gitlab-ci.yaml`) | Muévelo o renómbralo a `.gitlab-ci.yml` en la raíz, haz commit y push |
| El pipeline sale como fallido sin ejecutar ningún job, marcado como YAML inválido | Sangría incorrecta, tabuladores o falta de `:` | Abre **Build → Pipeline editor**: indica la línea del error. Corrige la sangría (dos espacios) y vuelve a publicar |
| El job se queda en **Pending** y no avanza | No hay ningún runner disponible para el proyecto | Mira **Settings → CI/CD → Runners**; si no aparece ninguno activo, en el terminal del Codespace ejecuta `infra/bootstrap.sh`, que arranca y registra el runner |
| El job falla y el log dice que no encuentra `scripts/validar.sh` | El comando no coincide con la ruta real del script | Comprueba en local que `sh scripts/validar.sh` funciona desde la raíz del proyecto y copia el comando tal cual |
| `git@gitlab: Permission denied (publickey).` al hacer `git push` | La clave de Ana no está registrada en GitLab | Regístrala como en el [lab de identidad y acceso](../M01-introduccion-git-gitlab/01-lab-identidad-y-acceso.md) |
