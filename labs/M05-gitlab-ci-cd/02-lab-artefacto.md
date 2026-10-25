# Lab — Artefacto

[← Página anterior](01-lab-primer-pipeline.md) · [Siguiente página →](03-lab-fallo-controlado.md)

Quien se incorpora al equipo no va a navegar por el repositorio: quiere el manual entero en un solo archivo. El pipeline de `manual-equipo` lo genera en el job `construir-manual` y lo guarda como **artefacto**. En este lab añades una página nueva al manual, dejas que el pipeline lo reconstruya y descargas el resultado.

### Objetivo

Descargar desde GitLab el artefacto del job `construir-manual` y comprobar que `public/manual-completo.md` incluye la página que acabas de añadir.

### Punto de partida

- URL: `https://gitlab.ejemplo.com` (la real te la da el formador). Usuario `ana` en los ejemplos: usa el tuyo.
- Credenciales: tu token de acceso personal (scopes `api` y `write_repository`).
- Estado: desde la carpeta del repositorio del curso, ejecuta:

  ```bash
  scripts/partida.sh manual-m05-artefacto --con-ci
  ```

  Crea `ana/manual-m05-artefacto` con el manual y cuatro commits; el último, «Añade pipeline de validación», trae el `.gitlab-ci.yml` con los stages `validar` y `construir`. Lo clona en `~/trabajo/manual-m05-artefacto`. Ese push inicial ya lanza un primer pipeline.
- Un runner compartido disponible en la instancia (lo aporta el curso).

### En qué consiste

Lees el job que genera el artefacto, lo pruebas en local, añades la página `docs/glosario.md`, publicas y descargas el manual generado. No cambias los scripts.

### 1 — Lee el job `construir-manual`

**Acción:**

```bash
cd ~/trabajo/manual-m05-artefacto
cat .gitlab-ci.yml
```

**Por qué:** el bloque `artifacts` es lo que convierte un archivo generado dentro del contenedor en algo que puedes descargar. Sin él, `public/` se pierde cuando el runner descarta el contenedor.

**Resultado esperado:** al final del archivo, el job:

```yaml
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

`paths` dice qué se guarda (la carpeta `public/` entera) y `expire_in`, cuándo lo borra GitLab para no acumular archivos. Si partes de un proyecto con solo el job `validar-paginas`, añade este bloque y `construir` a la lista de `stages`.

### 2 — Genera el manual en local

**Acción:** `sh scripts/construir.sh`

**Por qué:** así sabes qué produce el job antes de buscarlo en GitLab: es el mismo comando.

**Resultado esperado:**

```text
Generado public/manual-completo.md (65 líneas)
```

### 3 — Borra la copia local de `public/`

**Acción:** `rm -r public`

**Por qué:** `public/` es un resultado, no una fuente: se regenera en cada pipeline. Si lo dejas, `git status` lo muestra como `?? public/` y acabaría colándose en un commit.

**Resultado esperado:** `git status` dice `nothing to commit, working tree clean`.

### 4 — Añade la página del glosario

**Acción:** crea `docs/glosario.md` con este contenido y guarda:

```markdown
# Glosario

| Término | Qué significa |
|---------|---------------|
| MR | Merge request: propuesta para integrar una rama en `main` |
| Pipeline | Comprobaciones automáticas que se ejecutan en cada push |
```

**Por qué:** con una página nueva podrás comprobar que el artefacto que descargues es el de este cambio y no el del pipeline inicial. `scripts/construir.sh` recoge todas las páginas de `docs/`, así que no hace falta tocar nada más.

**Resultado esperado:** `git status --short` muestra `?? docs/glosario.md`, y `sh scripts/validar.sh` incluye la línea `revisado docs/glosario.md` y termina en `Todas las páginas son correctas`.

> [!TIP]
> En un manual de verdad añadirías también el enlace en el índice de `README.md`. Si lo haces, comprueba la ruta: el pipeline falla con un enlace roto.

### 5 — Registra y publica el cambio

**Acción:**

```bash
git add docs/glosario.md
git commit -m "Añade el glosario"
git push
```

**Por qué:** el push lanza el pipeline, y el pipeline regenera el manual con la página nueva.

**Resultado esperado:** el commit informa de `1 file changed, 6 insertions(+)` y `create mode 100644 docs/glosario.md`; el push termina en `main -> main`.

### 6 — Sigue el pipeline por sus dos stages

**Acción:** en GitLab, abre **Build → Pipelines** y haz clic en el pipeline del commit «Añade el glosario».

**Por qué:** `construir-manual` solo se ejecuta si `validar-paginas` ha terminado bien. Un manual con páginas rotas no llega a generarse.

**Resultado esperado:** el grafo muestra la columna `validar` con `validar-paginas` y, a su derecha, `construir` con `construir-manual`. El segundo empieza cuando acaba el primero; los dos terminan en **Passed**.

### 7 — Busca la subida del artefacto en el log

**Acción:** haz clic en el job `construir-manual` y ve al final del log.

**Por qué:** el log confirma qué ha guardado el job. Si `paths` no coincidiera con lo generado, lo verías aquí.

**Resultado esperado:** algo como esto (identificadores distintos; con el glosario el manual tiene más líneas):

```text
$ sh scripts/construir.sh
Generado public/manual-completo.md (75 líneas)
Uploading artifacts for successful job
Uploading artifacts...
public/: found 2 matching artifact files and directories 
Uploading artifacts as "archive" to coordinator... 201 Created  correlation_id=01M5MNWTY6C01W473C0W0TNKEG id=2 status=201 token=64_HpuqoY
Cleaning up project directory and file based variables
Job succeeded
```

Los «2» son la carpeta `public/` y el archivo que contiene.

### 8 — Explora el artefacto en GitLab

**Acción:** en el panel lateral del job, en **Job artifacts**, pulsa **Browse**. Entra en `public/` y abre `manual-completo.md`.

**Por qué:** puedes revisar el resultado sin descargar nada, por ejemplo al revisar una MR.

**Resultado esperado:** la carpeta `public/` con `manual-completo.md`. El panel indica también cuándo caduca el artefacto, según el `expire_in: 1 week` del job.

### 9 — Descarga el artefacto

**Acción:** vuelve a la página del job y, en **Job artifacts**, pulsa **Download**. Descomprime el archivo descargado.

**Por qué:** es lo que harías para pasarle el manual a quien se incorpora: un archivo, sin acceso al repositorio.

**Resultado esperado:** se descarga `artifacts.zip`; dentro hay `public/manual-completo.md`.

> [!TIP]
> No hace falta entrar en el job: en **Build → Pipelines**, la fila de cada pipeline tiene a la derecha un botón de descarga que lista los artefactos de sus jobs (`construir-manual:archive`).

### 10 — Comprueba que incluye el glosario

**Acción:** abre `public/manual-completo.md` en VS Code y busca `# Glosario`.

**Por qué:** demuestra que el artefacto es el del último push, generado a partir de lo que hay en el repositorio.

**Resultado esperado:** el archivo empieza por `# Manual del equipo` y contiene cada página separada por `---`. `# Glosario` aparece entre `# Bienvenida` y `# Herramientas`, porque el script recorre `docs/*.md` en orden alfabético.

## Comprueba tu entendimiento

**El artefacto es del pipeline, no de tu equipo**
Ejecuta `git status` en `~/trabajo/manual-m05-artefacto`.
→ `nothing to commit, working tree clean`: `public/` no está en el repositorio; solo existe como artefacto del job.

**Cada pipeline tiene su artefacto**
En **Build → Pipelines**, despliega el botón de descarga del pipeline inicial (el del commit «Añade pipeline de validación») y descarga su artefacto.
→ Su `manual-completo.md` no tiene `# Glosario`.

## Reto

### 1 — Un artefacto que dure menos

Haz que el artefacto de `construir-manual` caduque al día siguiente y comprueba el cambio en GitLab.

<details>
<summary>Ver solución</summary>

Cambia la última línea del job a:

```yaml
    expire_in: 1 day
```

Haz commit y push. En el panel **Job artifacts** del nuevo `construir-manual`, la fecha de caducidad es la del día siguiente. Los artefactos de pipelines anteriores conservan la suya.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| El job pasa, pero no aparece **Job artifacts** | Falta el bloque `artifacts` o está mal sangrado (fuera del job) | `artifacts` va al nivel de `script`, y `paths` dos espacios más a la derecha |
| El log dice que no ha encontrado archivos para subir | `paths` no coincide con la carpeta generada (`public` frente a `publico/`) | Usa la ruta que imprime `scripts/construir.sh`: `public/` |
| `construir-manual` aparece en **Skipped** | `validar-paginas` ha fallado y la stage siguiente no arranca | Abre el log de `validar-paginas`, corrige la línea `ERROR` y vuelve a publicar |
| `git status` muestra `?? public/` | Has ejecutado `scripts/construir.sh` en local | Bórralo con `rm -r public`; no se versiona |
| En un pipeline antiguo no hay botón **Download** | Su artefacto ha caducado (`expire_in`); GitLab conserva por defecto el del último pipeline correcto | Vuelve a ejecutar el pipeline: **Build → Pipelines** → **Run pipeline** sobre `main` |
