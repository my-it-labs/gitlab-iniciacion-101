# Lab — Publicar y comparar

[← Página anterior](02-lab-commits.md) · [Siguiente página →](04-lab-gitignore.md)

Un cambio en el proyecto no sirve al equipo hasta que está en GitLab, y antes de publicarlo conviene saber exactamente qué líneas cambian. En este lab, en el ordenador de Ana, revisas su cambio con `diff`, lo registras, lo encuentras en el historial con `log`, lo publicas con `push` y lo ves en GitLab. Después el proyecto cambia desde la web y traes ese cambio al ordenador de Ana con `fetch` y `pull`.

### Objetivo

El commit de Ana publicado y visible en **Code** → **Commits** de GitLab, y su copia local al día con un cambio hecho desde la web.

### Punto de partida

- El entorno de prácticas levantado ([El entorno de prácticas](../../infra/README.md)): GitLab en `http://localhost:8080`, cuenta `ana` con contraseña `Formacion-2026!`.
- No hace falta nada de páginas anteriores: el paso 1 crea `ana/manual-m02-publicar` en GitLab, lo clona en `~/trabajo/manual-m02-publicar` del ordenador de Ana y deja allí su identidad de Git y su clave SSH, así que `push` y `pull` no piden nada.

### En qué consiste

Haces un cambio en `docs/bienvenida.md` y lo recorres entero: `diff`, `add`, `diff --staged`, `commit`, `log`, `push` y el commit en GitLab. Luego editas `docs/herramientas.md` desde la web y lo traes con `fetch`, `status` y `pull`. Todo en la rama `main`; las ramas son el M03.

### 1 — Prepara el punto de partida y entra en el ordenador de Ana

**Acción:**

```bash
# 🖥️ Terminal del Codespace
scripts/partida.sh ana manual-m02-publicar
docker exec -it pc-ana bash
```

```bash
# 💻 Ordenador de Ana
cd ~/trabajo/manual-m02-publicar
```

**Por qué:** una copia local recién clonada y al día con GitLab, sin depender de otro lab.

**Resultado esperado:** el script acaba con `Copia local: ~/trabajo/manual-m02-publicar en el ordenador de ana (pc-ana)` y el prompt es `ana@pc-ana:~/trabajo/manual-m02-publicar$`. `git status` dice `Your branch is up to date with 'origin/main'.` y `nothing to commit, working tree clean`.

### 2 — Edita la página de bienvenida

**Acción** (📝 VS Code, ordenador de Ana): en `home-ana/trabajo/manual-m02-publicar/docs/bienvenida.md`, sección `## Primer día`, añade esta línea justo debajo de «Recoge tu portátil en el puesto de soporte.» y guarda:

```markdown
- Pide a tu persona de acogida que te dé de alta en el chat del equipo.
```

**Por qué:** es el cambio que vas a publicar: un paso del primer día que faltaba en el proyecto.

**Resultado esperado:** `bienvenida.md` aparece con una `M` en el explorador de VS Code.

### 3 — Mira qué has cambiado

**Acción** (💻 Ordenador de Ana): `git diff`

**Por qué:** `git status` te dice qué archivo cambió; `git diff` te dice qué líneas. Es lo que revisas antes de preparar el commit.

**Resultado esperado:**

```diff
diff --git a/docs/bienvenida.md b/docs/bienvenida.md
index 8c3d3aa..b95a616 100644
--- a/docs/bienvenida.md
+++ b/docs/bienvenida.md
@@ -5,6 +5,7 @@ Te damos la bienvenida al equipo. Este manual reúne lo que necesitas durante tu
 ## Primer día
 
 - Recoge tu portátil en el puesto de soporte.
+- Pide a tu persona de acogida que te dé de alta en el chat del equipo.
 - Revisa las [herramientas](herramientas.md) que vas a usar.
 - Lee las [normas de trabajo](normas-de-trabajo.md).
 
```

La línea con `+` es la nueva; las demás son contexto. `@@ -5,6 +5,7 @@` dice que el bloque empieza en la línea 5 y pasa de 6 a 7 líneas.

> [!TIP]
> Si la salida no cabe en pantalla, Git la muestra paginada: baja con las flechas y sal con <kbd>q</kbd>.

### 4 — Prepara el cambio

**Acción** (💻 Ordenador de Ana): `git add docs/bienvenida.md` y vuelve a ejecutar `git diff`.

**Por qué:** `git diff` sin opciones compara los archivos con lo preparado. Al preparar el cambio, ya no hay diferencia.

**Resultado esperado:** `git diff` no muestra nada.

### 5 — Mira lo que va a entrar en el commit

**Acción** (💻 Ordenador de Ana): `git diff --staged`

**Por qué:** compara lo preparado con el último commit, es decir, lo que va a guardar el próximo `git commit`. Es la última revisión antes de registrarlo.

**Resultado esperado:** el mismo diff del paso 3, con la línea `+- Pide a tu persona de acogida que te dé de alta en el chat del equipo.`

### 6 — Haz el commit

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
git commit -m "Añade el alta en el chat al primer día"
```

**Por qué:** registra el cambio con un mensaje que explica qué cambia en el proyecto.

**Resultado esperado:**

```text
[main 2d946d2] Añade el alta en el chat al primer día
 1 file changed, 1 insertion(+)
```

### 7 — Busca el commit en el historial

**Acción** (💻 Ordenador de Ana): `git log --oneline`

**Por qué:** una línea por commit, del más reciente al más antiguo. Es la forma rápida de ver qué ha pasado en el proyecto.

**Resultado esperado:**

```text
2d946d2 Añade el alta en el chat al primer día
cb5aea3 Añade normas de trabajo y scripts de validación
1191d01 Añade bienvenida y herramientas
b81c4d0 Crea el manual del equipo
```

Tus identificadores serán otros.

### 8 — Mira el detalle del último commit

**Acción** (💻 Ordenador de Ana): `git log -p -1`

**Por qué:** `-1` limita a un commit y `-p` añade su diff. Así sabes quién cambió qué, cuándo y qué líneas exactamente.

**Resultado esperado:**

```text
commit 2d946d2326e731144e51e6b2c6d71a655fbcff4d
Author: Ana <ana@equipo.local>
Date:   Sun Oct 25 10:02:55 2026 +0100

    Añade el alta en el chat al primer día

diff --git a/docs/bienvenida.md b/docs/bienvenida.md
index 8c3d3aa..b95a616 100644
--- a/docs/bienvenida.md
+++ b/docs/bienvenida.md
@@ -5,6 +5,7 @@ Te damos la bienvenida al equipo. Este manual reúne lo que necesitas durante tu
 ## Primer día
 
 - Recoge tu portátil en el puesto de soporte.
+- Pide a tu persona de acogida que te dé de alta en el chat del equipo.
 - Revisa las [herramientas](herramientas.md) que vas a usar.
 - Lee las [normas de trabajo](normas-de-trabajo.md).
```

### 9 — Comprueba que falta publicar

**Acción** (💻 Ordenador de Ana): `git status`

**Por qué:** antes del `push`, `git status` recuerda que GitLab no tiene el commit de Ana.

**Resultado esperado:**

```text
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
```

### 10 — Publica en GitLab

**Acción** (💻 Ordenador de Ana): `git push`

**Por qué:** sube a GitLab los commits que tienes y GitLab no. Hasta aquí, el cambio solo existía en el ordenador de Ana.

**Resultado esperado:**

```text
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 8 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 544 bytes | 544.00 KiB/s, done.
Total 4 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
To gitlab:ana/manual-m02-publicar.git
   cb5aea3..2d946d2  main -> main
```

La última línea es la que importa: `main` en GitLab ha pasado de `cb5aea3` al commit de Ana. `git status` vuelve a decir `Your branch is up to date with 'origin/main'.`

### 11 — Encuentra el commit en GitLab

**Acción** (🌐 GitLab, sesión de Ana): abre `http://localhost:8080/ana/manual-m02-publicar` y, en la barra lateral, pulsa **Code** → **Commits**.

**Por qué:** es el historial que ve todo el equipo, el mismo que `git log`.

**Resultado esperado:** el primero de la lista es «Añade el alta en el chat al primer día», de Ana, con el mismo identificador corto que en el ordenador de Ana. Debajo están los tres commits de partida.

> 📷 **Captura pendiente** · `M02-03-commits.png` — GitLab, sesión de Ana: **Code → Commits** con «Añade el alta en el chat al primer día» arriba.

### 12 — Abre su diff en GitLab

**Acción** (🌐 GitLab, sesión de Ana): pulsa el título del commit «Añade el alta en el chat al primer día».

**Por qué:** GitLab muestra el mismo diff que `git log -p -1`, sin necesidad de terminal. Es como lo verá quien revise el cambio.

**Resultado esperado:** la página del commit muestra el autor, el identificador completo y el archivo `docs/bienvenida.md` con `1` línea añadida, resaltada en verde: «- Pide a tu persona de acogida que te dé de alta en el chat del equipo.»

> 📷 **Captura pendiente** · `M02-03-diff-commit.png` — GitLab, sesión de Ana: página del commit con el diff de `docs/bienvenida.md`.

### 13 — Cambia una página desde la web

**Acción** (🌐 GitLab, sesión de Ana):
1. En **Code** → **Repository**, abre `docs` y pulsa `herramientas.md`.
2. Pulsa **Edit** → **Edit single file**.
3. En la fila de GitLab, cambia `Pídelo a soporte` por `Escribe a soporte@equipo.local`.
4. Pulsa **Commit changes**. En el diálogo, en **Commit message** escribe `Indica el correo de soporte en GitLab`, deja **Commit to the current main branch** y confirma con **Commit changes**.

**Por qué:** simula un cambio hecho fuera del ordenador de Ana, como cuando alguien corrige el proyecto desde el navegador. Ahora GitLab tiene un commit que la copia de Ana no tiene.

**Resultado esperado:** GitLab muestra `herramientas.md` con el texto nuevo y, en **Code** → **Commits**, «Indica el correo de soporte en GitLab» encima del de Ana.

> 📷 **Captura pendiente** · `M02-03-edicion-web.png` — GitLab, sesión de Ana: `herramientas.md` tras el commit desde la web.

### 14 — Trae los cambios sin aplicarlos

**Acción** (💻 Ordenador de Ana): `git fetch`

**Por qué:** `fetch` descarga los commits nuevos de GitLab pero no toca los archivos de Ana. Te deja ver qué hay antes de incorporarlo.

**Resultado esperado:**

```text
remote: Enumerating objects: 7, done.
remote: Counting objects: 100% (7/7), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 4 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
From gitlab:ana/manual-m02-publicar
   2d946d2..050fd2c  main       -> origin/main
```

`origin/main` (lo que el ordenador de Ana sabe de GitLab) ha avanzado; su `main` no. En VS Code, `home-ana/trabajo/manual-m02-publicar/docs/herramientas.md` sigue diciendo «Pídelo a soporte».

### 15 — Compara con GitLab

**Acción** (💻 Ordenador de Ana): `git status`

**Por qué:** después del `fetch`, `git status` ya sabe que GitLab va por delante.

**Resultado esperado:**

```text
On branch main
Your branch is behind 'origin/main' by 1 commit, and can be fast-forwarded.
  (use "git pull" to update your local branch)

nothing to commit, working tree clean
```

> [!NOTE]
> Sin `fetch`, `git status` compara con lo último que descargaste, así que puede decir `up to date` aunque GitLab tenga commits nuevos.

### 16 — Incorpora el cambio

**Acción** (💻 Ordenador de Ana): `git pull`

**Por qué:** `pull` hace el `fetch` y además lleva tu rama al commit de GitLab. Como Ana no tiene commits nuevos, solo tiene que avanzar (`Fast-forward`).

**Resultado esperado:**

```text
Updating 2d946d2..050fd2c
Fast-forward
 docs/herramientas.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```

`git log --oneline -2` muestra `050fd2c Indica el correo de soporte en GitLab` encima del commit de Ana, y en VS Code `herramientas.md` ya dice «Escribe a soporte@equipo.local»: `pull` ha cambiado el archivo en el ordenador de Ana.

## Comprueba tu entendimiento

**Las dos copias coinciden**
En el ordenador de Ana, ejecuta `git status` y compara `git log --oneline -1` con el primer commit de **Code** → **Commits** en GitLab.
→ `Your branch is up to date with 'origin/main'.` y el mismo identificador corto y mensaje en los dos sitios.

**Dónde está cada diff**
Cambia en VS Code cualquier palabra de `home-ana/trabajo/manual-m02-publicar/README.md`, guarda, ejecuta `git diff` y luego `git diff --staged`.
→ `git diff` muestra el cambio y `git diff --staged` no muestra nada, porque aún no está preparado. Deshazlo con `git restore README.md`.

## Reto

### 1 — Mira qué trae GitLab antes del pull

Edita otra vez desde la web una página (por ejemplo, en `docs/normas-de-trabajo.md` cambia «lunes a las 10:00» por «lunes a las 9:30») y haz `git fetch`. Sin hacer `pull`, averigua qué commits trae y qué líneas cambian.

<details>
<summary>Ver solución</summary>

```bash
# 💻 Ordenador de Ana
git log --oneline main..origin/main
git diff main origin/main
```

El primero lista los commits que están en `origin/main` y no en el `main` de Ana. El segundo muestra sus líneas: `-- Reunión de equipo: lunes a las 10:00.` y `+- Reunión de equipo: lunes a las 9:30.` Cuando lo hayas revisado, `git pull`.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| El commit no aparece en GitLab | Hiciste `commit` pero no `push` | `git status` dirá `ahead of 'origin/main'`; ejecuta `git push` |
| `! [rejected]        main -> main (fetch first)` | GitLab tiene commits que el ordenador de Ana no (alguien editó desde la web) | `git pull` y después `git push` |
| `git diff` no muestra nada y sí has cambiado el archivo | El cambio ya está preparado | Usa `git diff --staged` |
| `error: Your local changes to the following files would be overwritten by merge` al hacer `pull` | Hay cambios sin commit en el mismo archivo que trae GitLab | Haz commit de esos cambios (o deshazlos con `git restore <archivo>`) y repite `git pull` |
| `git@gitlab: Permission denied (publickey).` al hacer `push` o `pull` | La clave de Ana no está registrada en su perfil de GitLab | Regístrala como en el [lab de identidad y acceso](../M01-introduccion-git-gitlab/01-lab-identidad-y-acceso.md) |
