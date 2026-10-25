# Lab — Flujo completo

[← Página anterior](00-flujo-completo.md)

En las normas de trabajo del proyecto, la sección «Vacaciones» se queda en una frase, y cada semana alguien pregunta lo mismo. Te toca resolverlo de principio a fin, como Ana: en su ordenador y con su sesión de GitLab. Registras la tarea, la haces en su rama, la propones por merge request con el pipeline en verde y la integras en `main`, que está protegida. Esta vez los pasos dicen qué tiene que quedar hecho y lo que debes ver, no cada clic. Si te atascas, cada paso tiene una pista plegada.

### Objetivo

La página `docs/vacaciones.md` en `main` del proyecto `ana/manual-m06-flujo`, enlazada desde el `README.md` y desde `docs/normas-de-trabajo.md`, integrada por una merge request con el pipeline en verde, la issue cerrada, la rama borrada y la copia del ordenador de Ana al día.

### Punto de partida

- El entorno de prácticas levantado ([El entorno de prácticas](../../infra/README.md)): GitLab en `http://localhost:8080` y su runner; cuenta `ana` con contraseña `Formacion-2026!`.
- Los archivos de Ana se editan con VS Code en `home-ana/trabajo/manual-m06-flujo/`; Git, en su ordenador (`docker exec -it pc-ana bash`); lo demás, en GitLab con la sesión de Ana.
- Estado: no hace falta nada de otros módulos. El paso 1 crea el proyecto con su contenido, su historial y el pipeline, y el paso 2 protege `main`.

### En qué consiste

Una sola tarea del proyecto, recorrida entera: issue → rama con el número de la issue → commits → push → merge request con `Closes #n` → pipeline en verde → fusión → comprobación en GitLab y en local. Solo tocas tres archivos: creas `docs/vacaciones.md` y añades un enlace en `README.md` y otro en `docs/normas-de-trabajo.md`. No cambias el pipeline ni los scripts.

### 1 — Prepara el punto de partida

**Acción:** crea el proyecto con el pipeline incluido y entra en el ordenador de Ana:

```bash
# 🖥️ Terminal del Codespace
scripts/partida.sh ana manual-m06-flujo --con-ci
docker exec -it pc-ana bash
```

**Por qué:** el lab necesita el proyecto con su `.gitlab-ci.yml`, para que cada push de la rama se valide. Un nombre de proyecto propio te deja hacerlo sin depender de otros labs.

**Resultado esperado:** el script termina con:

```text
Proyecto: http://localhost:8080/ana/manual-m06-flujo
Copia local: ~/trabajo/manual-m06-flujo en el ordenador de ana (pc-ana)
```

En GitLab, el proyecto tiene 4 commits (el último, «Añade pipeline de validación») y en **Build → Pipelines** aparece un pipeline de `main` en estado **Passed**.

<details>
<summary>Si te atascas</summary>

- `Ya existe ana/manual-m06-flujo en GitLab`: ya lo creaste antes. Usa otro nombre, p. ej. `scripts/partida.sh ana manual-m06-flujo-2 --con-ci`, y sustitúyelo en el resto del lab.

</details>

### 2 — Protege `main` para que solo se integre por merge request

**Acción** (🌐 GitLab, sesión de Ana): en el proyecto, en **Settings → Repository → Protected branches**, cambia en la fila de `main` **Allowed to push and merge** a **No one**. Deja **Allowed to merge** como está.

**Por qué:** en el equipo nadie publica directamente en el proyecto. Con esto, ni siquiera Ana, que es la dueña del proyecto, puedes hacer push a `main`: todo cambio tiene que pasar por una merge request.

**Resultado esperado:** la fila de `main` muestra **No one** en **Allowed to push and merge** y **Maintainers** en **Allowed to merge**.

<details>
<summary>Si te atascas</summary>

Si no ves la sección **Protected branches**, despliégala con **Expand**. Si no ves **Settings**, no estás con la sesión de Ana o no estás en su proyecto: comprueba el avatar y que la ruta sea `ana/manual-m06-flujo`.

</details>

### 3 — Registra la tarea en una issue

**Acción** (🌐 GitLab, sesión de Ana): crea una issue con el título `Añadir una página de vacaciones` y una descripción que diga qué se espera: una página `docs/vacaciones.md` que amplíe la sección Vacaciones, enlazada desde el README y desde normas-de-trabajo. Asígnasela a Ana.

**Por qué:** la issue es el registro de la tarea. Su número es lo que une la rama, los commits y la MR, y lo que permite cerrarla sola al fusionar.

**Resultado esperado:** la issue aparece en **Plan → Issues** como **#1**, en estado **Open** y asignada a ti.

<details>
<summary>Si te atascas</summary>

**Plan → Issues → New issue**, rellena **Title** y **Description**, en **Assignee** elige **Assign to me** y pulsa **Create issue**.

</details>

### 4 — Crea la rama con el número de la issue

**Acción** (💻 Ordenador de Ana): en `~/trabajo/manual-m06-flujo`, ponte al día en `main` y crea una rama cuyo nombre empiece por el número de la issue, por ejemplo `1-pagina-de-vacaciones`.

**Por qué:** partir de `main` actualizada evita trabajar sobre una versión vieja del proyecto. El número en el nombre dice, a quien vea la rama en GitLab, a qué tarea pertenece.

**Resultado esperado:**

```text
Switched to a new branch '1-pagina-de-vacaciones'
```

<details>
<summary>Si te atascas</summary>

```bash
# 💻 Ordenador de Ana
cd ~/trabajo/manual-m06-flujo
git switch main
git pull
git switch -c 1-pagina-de-vacaciones
```

</details>

### 5 — Escribe la página en su propio commit

**Acción** (📝 VS Code, ordenador de Ana): crea `home-ana/trabajo/manual-m06-flujo/docs/vacaciones.md` con un título en la primera línea y el contenido que amplía la sección. Por ejemplo:

```markdown
# Vacaciones

Cómo se piden y se organizan las vacaciones en el equipo.

## Cómo pedirlas

- Pídelas a tu responsable con dos semanas de antelación.
- Indica las fechas exactas y quién te cubre.

## Calendario del equipo

Antes de pedirlas, revisa que no coinciden con las de más de la mitad del equipo.
```

Guarda el archivo y haz un commit **solo con esta página**, con un mensaje que diga qué hace.

**Por qué:** un commit con una sola idea se revisa y, si hace falta, se deshace sin arrastrar nada más. El título en la primera línea no es estético: `validar.sh` falla si falta.

**Resultado esperado:** antes del commit, `git status` muestra solo `docs/vacaciones.md` en `Untracked files`. Después:

```text
[1-pagina-de-vacaciones d3d74cb] Añade la página de vacaciones
 1 file changed, 12 insertions(+)
 create mode 100644 docs/vacaciones.md
```

El hash será otro en tu caso.

<details>
<summary>Si te atascas</summary>

```bash
# 💻 Ordenador de Ana
git status
git add docs/vacaciones.md
git commit -m "Añade la página de vacaciones"
```

</details>

### 6 — Enlaza la página en un segundo commit

**Acción** (📝 VS Code, ordenador de Ana): añade un enlace a la página en el índice del `README.md` (una línea más en la lista, con el mismo formato que las que ya hay) y otro al final de la sección «Vacaciones» de `docs/normas-de-trabajo.md`, con una frase como «Todo el detalle está en Vacaciones». Ten en cuenta desde qué carpeta enlaza cada archivo. Antes de confirmar, ejecuta `sh scripts/validar.sh` en el ordenador de Ana. Luego haz un commit con los dos archivos.

**Por qué:** una página a la que no se llega no existe para quien lee el proyecto. Ejecutar la validación en local te ahorra un pipeline rojo: es el mismo script que lanza el job `validar-paginas`.

**Resultado esperado:** `git diff --stat` muestra una línea añadida en cada archivo:

```text
 README.md                 | 1 +
 docs/normas-de-trabajo.md | 1 +
 2 files changed, 2 insertions(+)
```

La validación termina con `revisado docs/vacaciones.md` y `Todas las páginas son correctas`, y `git log --oneline` muestra los dos commits de Ana encima de los cuatro de partida:

```text
679f7c4 Enlaza vacaciones desde el README y las normas de trabajo
d3d74cb Añade la página de vacaciones
cb850fa Añade pipeline de validación
6635980 Añade normas de trabajo y scripts de validación
066adcb Añade bienvenida y herramientas
f3089be Crea el manual del equipo
```

<details>
<summary>Si te atascas</summary>

`normas-de-trabajo.md` ya está dentro de `docs/`, así que enlaza `vacaciones.md`, no `docs/vacaciones.md`. El `README.md` está en la raíz y enlaza `docs/vacaciones.md`.

```bash
# 💻 Ordenador de Ana
sh scripts/validar.sh
git add README.md docs/normas-de-trabajo.md
git commit -m "Enlaza vacaciones desde el README y las normas de trabajo"
```

</details>

### 7 — Publica la rama

**Acción** (💻 Ordenador de Ana): sube la rama a GitLab.

**Por qué:** hasta ahora los dos commits solo están en el ordenador de Ana. Al publicarlos, GitLab los guarda y lanza el pipeline sobre la rama.

**Resultado esperado:** Git crea la rama remota y GitLab sugiere el enlace para abrir la MR:

```text
remote: 
remote: To create a merge request for 1-pagina-de-vacaciones, visit:
remote:   http://localhost:8080/ana/manual-m06-flujo/-/merge_requests/new?merge_request%5Bsource_branch%5D=1-pagina-de-vacaciones
remote: 
To gitlab:ana/manual-m06-flujo.git
 * [new branch]      1-pagina-de-vacaciones -> 1-pagina-de-vacaciones
branch '1-pagina-de-vacaciones' set up to track 'origin/1-pagina-de-vacaciones'.
```

En **Code → Branches** aparece `1-pagina-de-vacaciones` junto a `main`.

<details>
<summary>Si te atascas</summary>

```bash
# 💻 Ordenador de Ana
git push -u origin 1-pagina-de-vacaciones
```

Si responde `Permission denied (publickey)`, la clave de Ana no está en GitLab: vuelve a ejecutar el paso 1 con otro nombre de proyecto, que la registra.

</details>

### 8 — Propón el cambio con una merge request ligada a la issue

**Acción** (🌐 GitLab, sesión de Ana): crea la merge request de `1-pagina-de-vacaciones` hacia `main`. Dale un título que diga qué aporta y escribe en la descripción `Closes #1`. Deja marcada la opción de borrar la rama al fusionar.

**Por qué:** la MR es donde el equipo ve el diff, el pipeline y la conversación antes de que el cambio entre en el proyecto. `Closes #1` hace que la issue se cierre sola al fusionar.

**Resultado esperado:** la MR queda como **!1**, en estado **Open**, con origen `1-pagina-de-vacaciones` y destino `main`. En su pestaña **Commits** están los dos commits de Ana y en **Changes**, los tres archivos. En la issue #1 aparece la MR relacionada.

<details>
<summary>Si te atascas</summary>

Abre el enlace que te dio el push o ve a **Code → Merge requests → New merge request**, elige la rama de origen y pulsa **Compare branches and continue**. En la descripción, `Closes #1`; comprueba que **Delete source branch when merge request is accepted.** está marcada y pulsa **Create merge request**.

</details>

### 9 — Lleva el pipeline a verde

**Acción** (🌐 GitLab, sesión de Ana): mira el pipeline de la MR. Si termina en verde, pasa al paso siguiente. Si falla, abre el job que ha fallado y lee su log; después, en el ordenador de Ana (💻), corrige el problema en la rama con un commit nuevo y vuelve a hacer push.

**Por qué:** el pipeline es la comprobación que el equipo acordó para el proyecto. Un pipeline rojo no se fusiona: se lee el log y se arregla en la misma rama, y la MR se actualiza sola con el commit nuevo.

**Resultado esperado:** en la pestaña **Overview** de la MR, el pipeline aparece como **Passed**, con los jobs `validar-paginas` y `construir-manual` en verde. Si hubo un fallo, el log de `validar-paginas` señala el archivo y el motivo, por ejemplo un enlace con la ruta equivocada:

```text
$ sh scripts/validar.sh
revisado README.md
revisado docs/bienvenida.md
revisado docs/herramientas.md
ERROR docs/normas-de-trabajo.md: enlace roto a docs/vacaciones.md
revisado docs/normas-de-trabajo.md
revisado docs/vacaciones.md
1 error(es)
```

En ese caso `construir-manual` queda **skipped**: su stage no llega a empezar.

<details>
<summary>Si te atascas</summary>

- Para ver el log: en la MR, pulsa el estado del pipeline y luego el job con la cruz roja (o **Build → Jobs**).
- Para el error del ejemplo: en `docs/normas-de-trabajo.md`, cambia `(docs/vacaciones.md)` por `(vacaciones.md)`, ejecuta `sh scripts/validar.sh` y, cuando diga `Todas las páginas son correctas`:

```bash
# 💻 Ordenador de Ana
git add docs/normas-de-trabajo.md
git commit -m "Corrige el enlace a vacaciones en normas de trabajo"
git push
```

- Si el pipeline se queda en **Pending**, no hay runner disponible: en el terminal del Codespace, `infra/bootstrap.sh` lo arranca y lo registra.

</details>

> 📷 **Captura pendiente** · `M06-01-mr-pipeline-verde.png` — GitLab, sesión de Ana: la MR con el pipeline en **Passed**.

### 10 — Fusiona la merge request

**Acción** (🌐 GitLab, sesión de Ana): con el pipeline en verde y los cambios revisados en **Changes**, fusiona la MR.

**Por qué:** es el único camino hacia `main` que deja abierto la protección del paso 2. Al fusionar, GitLab ejecuta lo que dejaste preparado: cerrar la issue y borrar la rama.

**Resultado esperado:** la MR pasa a **Merged**. En **Build → Pipelines** arranca un pipeline nuevo sobre `main`, que termina en **Passed**.

<details>
<summary>Si te atascas</summary>

Botón **Merge** en la pestaña **Overview** de la MR. Si no aparece y ves un aviso de conflictos, `main` ha cambiado desde que creaste la rama: consulta la tabla de errores al final.

</details>

### 11 — Comprueba lo que ha hecho GitLab al fusionar

**Acción** (🌐 GitLab, sesión de Ana): revisa la issue #1, la lista de ramas y el archivo en `main`.

**Por qué:** la fusión no termina en el botón. Una tarea está cerrada cuando la issue lo refleja, no quedan ramas sueltas y el proyecto de `main` tiene la página.

**Resultado esperado:**
- En **Plan → Issues**, la #1 está **Closed** y su actividad dice que la cerró la merge request !1.
- En **Code → Branches** solo queda `main`.
- En **Code → Repository**, `docs/vacaciones.md` está en `main` y el `README.md` del proyecto muestra el enlace «Vacaciones».

<details>
<summary>Si te atascas</summary>

Si la issue sigue **Open**, la descripción de la MR no llevaba `Closes #1` (o tenía otro número): ciérrala a mano con **Close issue**. Si la rama sigue en **Code → Branches**, bórrala desde ahí con el icono de papelera.

</details>

> 📷 **Captura pendiente** · `M06-01-issue-cerrada.png` — GitLab, sesión de Ana: la issue #1 cerrada por la MR !1.

### 12 — Pon al día el ordenador de Ana

**Acción** (💻 Ordenador de Ana): vuelve a `main`, trae lo fusionado, borra la rama local ya integrada y limpia la referencia a la rama remota borrada.

**Por qué:** la copia de Ana sigue en la rama de la tarea y su `main` no sabe nada de la fusión. La siguiente tarea empezará desde aquí, así que tiene que reflejar lo que hay en GitLab.

**Resultado esperado:** `git pull` trae el commit de merge y los de Ana:

```text
Updating cb850fa..0c00c0c
Fast-forward
 README.md                 |  1 +
 docs/normas-de-trabajo.md |  1 +
 docs/vacaciones.md        | 12 ++++++++++++
 3 files changed, 14 insertions(+)
 create mode 100644 docs/vacaciones.md
```

Después, `git branch -d` responde `Deleted branch 1-pagina-de-vacaciones (was 679f7c4).`, `git fetch --prune` muestra `- [deleted]         (none)     -> origin/1-pagina-de-vacaciones` y `git status` termina en `nothing to commit, working tree clean`.

<details>
<summary>Si te atascas</summary>

```bash
# 💻 Ordenador de Ana
git switch main
git pull
git branch -d 1-pagina-de-vacaciones
git fetch --prune
git status
```

</details>

## Comprueba tu entendimiento

**El historial cuenta la tarea**
Ejecuta `git log --oneline --graph -5` en `main`.
→ Ves el commit de merge `Merge branch '1-pagina-de-vacaciones' into 'main'` y, en la rama que sale y vuelve a entrar, los commits de Ana, cada uno con un mensaje que dice una sola cosa:

```text
*   0c00c0c Merge branch '1-pagina-de-vacaciones' into 'main'
|\  
| * 679f7c4 Enlaza vacaciones desde el README y las normas de trabajo
| * d3d74cb Añade la página de vacaciones
|/  
* cb850fa Añade pipeline de validación
* 6635980 Añade normas de trabajo y scripts de validación
```

Si corregiste el pipeline en el paso 9, aparece también «Corrige el enlace a vacaciones en normas de trabajo»: un arreglo con su propio mensaje sigue siendo historial claro.

**Cada pieza remite a las demás**
Abre la MR !1 en **Code → Merge requests** (filtro **Merged**).
→ En su descripción está `Closes #1`, la issue enlazada sale como cerrada y el pipeline de la MR, como **Passed**.

**`main` no admite atajos**
En `main`, ejecuta `git commit --allow-empty -m "Prueba de push directo"` y `git push`.
→ El push se rechaza con `remote: GitLab: You are not allowed to push code to protected branches on this project.` y ` ! [remote rejected] main -> main (pre-receive hook declined)`. Deshaz el commit de prueba con `git reset --hard origin/main`.

## Reto

### 1 — Que `public/` no llegue nunca al historial

Si ejecutas `sh scripts/construir.sh` en el ordenador de Ana, `git status` muestra `public/` en `Untracked files`. Haz que el repositorio lo ignore siguiendo el flujo completo, con una issue nueva y una MR que la cierre. Al terminar, el historial de `main` debe dejar claro qué se hizo y por qué con solo leer los mensajes.

<details>
<summary>Ver solución</summary>

1. Issue **#2** «Ignorar la carpeta generada public/».
2. `git switch main`, `git pull` y `git switch -c 2-ignorar-public`.
3. Crea `.gitignore` con la línea `public/`, ejecuta `sh scripts/construir.sh` y comprueba que `git status` ya no lista `public/`, solo `.gitignore`.
4. `git add .gitignore` y `git commit -m "Ignora la carpeta public/ que genera construir.sh"`.
5. `git push -u origin 2-ignorar-public`, MR con `Closes #2`, pipeline en verde y **Merge**.
6. `git switch main`, `git pull`, `git branch -d 2-ignorar-public`.

`git log --oneline -3` muestra el merge de `2-ignorar-public` y, debajo, el commit con su mensaje. Si además lo quieres explicar a quien llegue nuevo, la sección «Cómo se mantiene» del `README.md` es el sitio, en un commit aparte.

</details>

### 2 — Que un pipeline rojo no se pueda fusionar

En este proyecto, nada impide pulsar **Merge** con el pipeline en rojo. Cámbialo y compruébalo con una rama que rompa la validación a propósito.

<details>
<summary>Ver solución</summary>

En **Settings → Merge requests**, en **Merge checks**, marca **Pipelines must succeed** y pulsa **Save changes**. Para probarlo, crea una rama, quita el `# ` de la primera línea de una página, publícala y abre una MR: con el pipeline **Failed**, la MR no ofrece **Merge** y explica que el pipeline tiene que terminar bien. Cierra después esa MR sin fusionar (**Close merge request**) y borra la rama.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| `remote: GitLab: You are not allowed to push code to protected branches on this project.` | Los commits se hicieron en `main` y no en la rama de la tarea | `git switch -c 1-pagina-de-vacaciones` (la rama nueva se lleva los commits), `git push -u origin 1-pagina-de-vacaciones` y abre la MR desde ahí |
| La MR no muestra los últimos cambios | Se hizo el commit pero no el push, o el push fue a otra rama | `git status` (`Your branch is ahead of …`) y `git push` desde la rama de la tarea |
| `ERROR docs/normas-de-trabajo.md: enlace roto a docs/vacaciones.md` | El enlace es relativo a la carpeta del archivo, y `normas-de-trabajo.md` ya está en `docs/` | Enlaza `vacaciones.md` desde `docs/normas-de-trabajo.md`; desde el `README.md`, `docs/vacaciones.md` |
| `ERROR docs/vacaciones.md: falta el título (la primera línea debe empezar por '# ')` | La página empieza sin `# ` o con otro nivel de título | Primera línea `# Vacaciones`, nuevo commit y push |
| La MR avisa de conflictos y no deja fusionar | `main` ha cambiado en las mismas líneas desde que se creó la rama | En la rama de la tarea, `git pull origin main`, resuelve el conflicto, `git add`, `git commit` y `git push` |
| La issue sigue **Open** tras fusionar | Faltaba `Closes #1` en la descripción de la MR, o el número no era el de la issue | Ciérrala a mano con **Close issue**; la próxima vez, revisa la descripción antes de fusionar |
| En la MR aparece `public/manual-completo.md` | Se ejecutó `construir.sh` y luego `git add .` | `git rm -r --cached public`, commit, push, y añade `public/` a `.gitignore` (Reto 1) |
| `git branch -d` responde `error: the branch '1-pagina-de-vacaciones' is not fully merged` | El `main` del ordenador de Ana aún no tiene la fusión | Haz antes `git switch main` y `git pull`, y repite `git branch -d` |
| El pipeline se queda en **Pending** | No hay runner disponible para el proyecto | En el terminal del Codespace, `infra/bootstrap.sh` arranca y registra el runner |
