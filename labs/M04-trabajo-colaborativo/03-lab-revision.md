# Lab — Revisión

[← Página anterior](02-lab-de-issue-a-mr.md) · [Siguiente página →](../M05-gitlab-ci-cd/README.md)

`luis` ha propuesto en una merge request el horario de verano del manual. Antes de que entre en `main`, `ana` lo revisa: comenta una línea, propone una redacción con una sugerencia de cambio y, cuando `luis` lo ha corregido, aprueba y fusiona. La issue se cierra sola y la rama desaparece.

### Objetivo

La MR de `luis` revisada con un comentario y una sugerencia, corregida, fusionada en `main`, con su issue cerrada y su rama borrada.

### Punto de partida

- Instancia de GitLab del curso: `https://gitlab.ejemplo.com` (la URL real te la da el formador).
- Por parejas: **`ana`** es la dueña del proyecto y la revisora; **`luis`** es el autor de la MR. Usa vuestros usuarios reales. Si sois tres, la tercera persona también revisa: hace los pasos 3 a 5 con su propio comentario.
- Cada uno con su token de acceso personal y su identidad de Git configurada.
- Estado: lo preparáis en los pasos 1 y 2. No hace falta haber hecho ninguna página anterior.

### En qué consiste

Preparáis un proyecto compartido con una MR abierta de `luis` (pasos 1 y 2) y hacéis su revisión completa hasta la fusión. Para practicar la creación de la issue y la MR con calma, está [02 — De la issue a la merge request](02-lab-de-issue-a-mr.md).

### 1 — Prepara el proyecto compartido (ana)

**Acción:** desde la carpeta del repo del curso:

```bash
scripts/partida.sh manual-m04-revision
```

Después, en `https://gitlab.ejemplo.com/ana/manual-m04-revision`:
1. **Manage → Members → Invite members**: usuario `luis`, rol **Developer**, **Invite**.
2. **Settings → Repository → Protected branches** (**Expand**): en la fila de `main`, **Allowed to push and merge** → **No one** (deja **Allowed to merge** en **Maintainers**).

**Por qué:** `luis` necesita ser miembro para proponer cambios, y con `main` protegida solo se integra lo que pasa por revisión.

**Resultado esperado:** el script termina con `Proyecto: https://gitlab.ejemplo.com/ana/manual-m04-revision`; `luis` aparece como **Developer** en **Manage → Members**, y `main` tiene **No one** en **Allowed to push and merge**.

### 2 — Abre la MR que se va a revisar (luis)

**Acción:**
1. En el proyecto, **Plan → Issues → New issue**: **Title** `Las normas no dicen el horario de verano`, **Assign to me**, **Create issue**. Será la **#1**.
2. En la terminal (usuario `luis` y tu token cuando Git los pida):

   ```bash
   git clone https://gitlab.ejemplo.com/ana/manual-m04-revision.git ~/trabajo/manual-m04-revision
   cd ~/trabajo/manual-m04-revision
   git switch -c 1-horario-verano
   ```

3. En `docs/normas-de-trabajo.md`, debajo de la línea «El horario de referencia es de 9:00 a 17:00…», añade una línea en blanco y `Del 1 de julio al 31 de agosto, el horario es de 8:00 a 15:00.`
4. Registra y publica:

   ```bash
   git commit -am "Añade el horario de verano (#1)"
   git push -u origin 1-horario-verano
   ```

5. Abre el enlace del push y crea la MR: **Title** `Añade el horario de verano`, **Description** con la línea `Closes #1`, **Reviewer** `ana`, **Delete source branch when merge request is accepted.** marcada, **Create merge request**.

**Por qué:** es el estado que encuentra un revisor cada día: una MR pequeña, enlazada a su issue y asignada a él.

**Resultado esperado:** la MR **!1** abierta, de `1-horario-verano` a `main`, con `ana` como revisora y `Closes #1` en la descripción.

### 3 — Lee los cambios (ana)

**Acción:**
1. Abre **Code → Merge requests** y entra en la MR !1.
2. Pulsa la pestaña **Changes**.

**Por qué:** se revisa lo que cambia, no el fichero entero. El diff te enseña exactamente qué entraría en `main`.

**Resultado esperado:** un fichero, `docs/normas-de-trabajo.md`, con dos líneas añadidas en verde: una en blanco y `Del 1 de julio al 31 de agosto, el horario es de 8:00 a 15:00.`

### 4 — Comenta una línea (ana)

**Acción:**
1. Pasa el ratón por la línea añadida «Del 1 de julio…» y pulsa el icono de comentario que aparece a su izquierda.
2. Escribe:

   ```markdown
   En verano la reunión de los lunes pasa a las 9:00. Añádelo en «Reuniones», por favor.
   ```

3. Pulsa **Start a review**.

**Por qué:** el comentario queda pegado a la línea que lo motiva, no perdido en un chat. Con **Start a review**, tus comentarios se guardan como pendientes y `luis` los recibe todos juntos, no uno a uno.

**Resultado esperado:** el comentario aparece bajo la línea marcado como pendiente, y GitLab muestra que tienes una revisión en curso con 1 comentario.

### 5 — Propón una redacción con una sugerencia (ana)

**Acción:**
1. En la misma línea, abre otro comentario.
2. Pulsa el botón **Insert suggestion** de la barra del editor (o escribe el bloque a mano). Deja el bloque así:

   ````markdown
   Más corto:

   ```suggestion
   En julio y agosto, el horario es de 8:00 a 15:00.
   ```
   ````

3. Pulsa **Add to review**.

**Por qué:** cuando sabes cómo debería quedar, una sugerencia ahorra la ida y vuelta: `luis` la aplica con un clic, sin reescribir nada.

**Resultado esperado:** la vista previa muestra un mini-diff: en rojo la línea actual, en verde la tuya. Tu revisión pendiente tiene ahora 2 comentarios.

### 6 — Envía la revisión (ana)

**Acción:** pulsa **Submit review**, en la barra de tu revisión pendiente al pie de la merge request, y confírmalo en el panel que se abre.

**Por qué:** hasta ahora nadie veía tus comentarios. Al enviarlos, `luis` recibe la revisión completa de una vez.

**Resultado esperado:** los dos comentarios dejan de estar pendientes y aparecen también en la pestaña **Overview**, cada uno como un hilo sin resolver.

### 7 — Aplica la sugerencia (luis)

**Acción:**
1. Abre la MR !1, pestaña **Overview** o **Changes**.
2. En el hilo de la sugerencia, pulsa **Apply suggestion**.
3. Deja el mensaje de commit que propone GitLab y confirma con **Apply**.

**Por qué:** el cambio que proponía `ana` entra en tu rama como un commit, sin editar el fichero.

**Resultado esperado:** el hilo de la sugerencia queda resuelto y en la pestaña **Commits** aparece un segundo commit, hecho desde la web, sobre la rama `1-horario-verano`.

### 8 — Trae el commit de la sugerencia (luis)

**Acción:** en tu copia local, en la rama `1-horario-verano`:

```bash
git pull
```

**Por qué:** el commit de la sugerencia solo existe en GitLab. Si no lo traes primero, tu próximo push sería rechazado.

**Resultado esperado:**

```console
Updating 99f6670..7883163
Fast-forward
 docs/normas-de-trabajo.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```

(Los identificadores de commit serán otros.) En el fichero, la línea ya dice `En julio y agosto, el horario es de 8:00 a 15:00.`

### 9 — Responde al comentario con un commit (luis)

**Acción:** en `docs/normas-de-trabajo.md`, cambia la línea de la reunión de equipo para que diga:

```markdown
- Reunión de equipo: lunes a las 10:00 (en julio y agosto, a las 9:00).
```

Después:

```bash
git commit -am "Indica la hora de la reunión en verano (#1)"
git push
```

**Por qué:** este comentario no traía sugerencia, así que el cambio lo haces tú. Al subirlo a la misma rama, la MR se actualiza sola: no hay que abrir otra.

**Resultado esperado:**

```console
[1-horario-verano a8ee575] Indica la hora de la reunión en verano (#1)
 1 file changed, 1 insertion(+), 1 deletion(-)
```

```console
To https://gitlab.ejemplo.com/ana/manual-m04-revision.git
   7883163..a8ee575  1-horario-verano -> 1-horario-verano
```

En la MR aparece el tercer commit. Responde al hilo del comentario con «Hecho» y pulsa **Resolve thread**.

### 10 — Aprueba la MR (ana)

**Acción:**
1. En la MR !1, pestaña **Changes**, comprueba los dos cambios nuevos.
2. En **Overview**, pulsa **Approve**.

**Por qué:** la aprobación deja constancia de que alguien distinto del autor ha revisado el cambio. En GitLab Free es opcional: no bloquea la fusión, pero queda registrada.

**Resultado esperado:** la MR indica que la has aprobado tú (`Approved by` con tu avatar).

> [!NOTE]
> Si en vuestra instancia no ves el botón **Approve**, deja un comentario «Revisado, lo fusiono» y sigue con el paso siguiente.

### 11 — Fusiona (ana)

**Acción:**
1. En **Overview**, comprueba que la casilla **Delete source branch** está marcada.
2. Pulsa **Merge**.

**Por qué:** como Maintainer eres de los pocos que pueden fusionar en `main`. Borrar la rama al fusionar deja el proyecto limpio: su trabajo ya está en `main`.

**Resultado esperado:** la MR pasa a **Merged**. En **Code → Repository**, `docs/normas-de-trabajo.md` en `main` muestra el horario de verano y la reunión de verano. En **Code → Branches** ya no aparece `1-horario-verano`.

### 12 — Comprueba la issue (ana o luis)

**Acción:** abre **Plan → Issues** y busca la #1 (pestaña **Closed**).

**Por qué:** gracias a `Closes #1`, nadie tiene que acordarse de cerrar la issue: se cierra cuando el cambio entra de verdad en `main`.

**Resultado esperado:** la issue #1 está **Closed**, y en su actividad se indica que se cerró con la merge request !1.

### 13 — Pon al día tu copia local (luis)

**Acción:**

```bash
git switch main
git pull
git branch -d 1-horario-verano
git fetch --prune
```

**Por qué:** tu `main` local aún no tiene la fusión, y la rama local ya no sirve: su trabajo está en `main` y la de GitLab se borró.

**Resultado esperado:** `git pull` termina en `Fast-forward`, `git branch -d` dice `Deleted branch 1-horario-verano (was …).` y `git fetch --prune` muestra `- [deleted]         (none)     -> origin/1-horario-verano`.

## Comprueba tu entendimiento

**Historia de la revisión**
Abre la MR !1, pestaña **Overview**.
→ Ves los dos hilos resueltos, la aprobación de `ana`, los tres commits y la fusión.

**Quién cambió qué**
`luis`: `git log --oneline -4` en `main`.
→ Un commit de fusión `Merge branch '1-horario-verano' into 'main'` y, debajo, tus dos commits y el de la sugerencia.

**El autor no fusiona**
`luis`: abre otra MR tuya (o una nueva desde cualquier rama).
→ No tienes botón **Merge**: en este proyecto solo fusionan los Maintainers.

## Reto

### 1 — Revisión al revés

Cambiad los papeles: `ana` crea una issue (por ejemplo, «Las vacaciones no dicen dónde se registran»), la resuelve en una rama `2-…` y abre la MR con `Closes #2`; `luis` la revisa con una sugerencia. ¿Puede `luis` fusionarla?

<details>
<summary>Ver solución</summary>

`luis` puede comentar, sugerir y aprobar; la sugerencia la aplica `ana`, autora de la MR. Pero **no** puede fusionar: **Allowed to merge** es **Maintainers** y `luis` es Developer. La fusiona `ana` tras la aprobación de `luis`. Revisar no es lo mismo que tener permiso para integrar.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| `luis` no ve los comentarios de `ana` | `ana` no ha enviado la revisión: siguen pendientes | `ana` pulsa **Submit review** en la barra de su revisión pendiente |
| No aparece **Apply suggestion** | El comentario no tiene un bloque `suggestion`, o lo escribió con otra marca | Edita el comentario: tres comillas invertidas seguidas de `suggestion` |
| El push del paso 9 es rechazado (`! [rejected] … (fetch first)`) | No hiciste `git pull` tras aplicar la sugerencia | `git pull` y repite el push |
| No ves el botón **Merge** | Estás con la cuenta de `luis`, o quedan hilos sin resolver si el proyecto lo exige | Fusiona con la cuenta de `ana`; resuelve los hilos |
| La issue sigue abierta tras fusionar | La descripción de la MR no tenía `Closes #1` o tenía otro número | Ciérrala a mano desde la issue y revisa la descripción la próxima vez |
| `git branch -d` dice `not fully merged` | No hiciste `git pull` en `main` antes | `git switch main`, `git pull` y repite |
