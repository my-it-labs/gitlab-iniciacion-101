# Lab — De la issue a la merge request

[← Página anterior](01-lab-proyecto-compartido.md) · [Siguiente página →](03-lab-revision.md)

En `docs/normas-de-trabajo.md` el manual dice que el horario es de 9:00 a 17:00, pero en verano el equipo tiene otro y nadie lo ha escrito. En este lab, `luis` registra el problema como issue, lo arregla en una rama con el número de la issue y abre la merge request que la cerrará. Al final, issue, rama y MR quedan enlazadas entre sí.

### Objetivo

Una issue #3 asignada, una rama `3-horario-verano` con el cambio y una merge request abierta con `Closes #3`, visibles desde la issue.

### Punto de partida

- Instancia de GitLab del curso: `https://gitlab.ejemplo.com` (la URL real te la da el formador).
- Por parejas: **`ana`** es la dueña del proyecto y **`luis`** su pareja, que hace el cambio. Usa vuestros usuarios reales. Si sois tres, la tercera persona sigue los pasos de `luis` con su propia issue y su propia rama.
- Cada uno con su token de acceso personal y su identidad de Git configurada.
- Estado: lo preparáis en los pasos 1 a 3. No hace falta haber hecho ninguna página anterior.

### En qué consiste

`ana` prepara el proyecto compartido con dos issues ya registradas; `luis` crea la tercera, hace el cambio en su rama y abre la MR. La revisión y la fusión no entran aquí: están en [03 — Revisión](03-lab-revision.md).

### 1 — Prepara el punto de partida (ana)

**Acción:** desde la carpeta del repo del curso:

```bash
scripts/partida.sh manual-m04-issue
```

Después, en `https://gitlab.ejemplo.com/ana/manual-m04-issue`:
1. **Manage → Members → Invite members**: usuario `luis`, rol **Developer**, **Invite**.
2. **Settings → Repository → Protected branches** (**Expand**): en la fila de `main`, **Allowed to push and merge** → **No one** (deja **Allowed to merge** en **Maintainers**).

**Por qué:** `luis` necesita ser miembro para trabajar en el proyecto, y con `main` protegida el cambio solo puede entrar por merge request, que es lo que vais a practicar.

**Resultado esperado:** el script termina con `Proyecto: https://gitlab.ejemplo.com/ana/manual-m04-issue`. En **Manage → Members** aparece `luis` como **Developer**, y la fila de `main` muestra **No one** en **Allowed to push and merge**.

### 2 — Registra las issues pendientes del equipo (ana)

**Acción:** en **Plan → Issues → New issue**, crea dos issues, cada una solo con su **Title** y **Create issue**:
1. `La bienvenida no dice dónde pedir el portátil`
2. `Falta el canal del chat del equipo en Herramientas`

**Por qué:** un manual vivo siempre tiene trabajo pendiente registrado. Además, así la issue de `luis` será la #3, como en el resto de esta página.

**Resultado esperado:** en **Plan → Issues**, dos issues abiertas, **#1** y **#2**.

### 3 — Clona el proyecto (luis)

**Acción:**

```bash
git clone https://gitlab.ejemplo.com/ana/manual-m04-issue.git ~/trabajo/manual-m04-issue
cd ~/trabajo/manual-m04-issue
```

Cuando Git pida usuario, escribe `luis`; como contraseña, tu token.

**Por qué:** vas a hacer el cambio en tu equipo, con tu identidad, sobre el proyecto de tu pareja.

**Resultado esperado:** `Cloning into '/home/luis/trabajo/manual-m04-issue'...` y, dentro, `README.md`, `docs/` y `scripts/`.

### 4 — Crea la issue (luis)

**Acción:**
1. En `https://gitlab.ejemplo.com/ana/manual-m04-issue`, ve a **Plan → Issues → New issue**.
2. **Title:** `Las normas no dicen el horario de verano`.
3. **Description:**

   ```markdown
   En «Horario» solo aparece el de 9:00 a 17:00. Falta el horario de verano
   (del 1 de julio al 31 de agosto, de 8:00 a 15:00).
   ```

4. En **Assignee**, pulsa **Assign to me**.
5. Pulsa **Create issue**.

**Por qué:** la issue deja escrito qué falta y quién se encarga antes de tocar nada. Si mañana alguien pregunta por qué cambió el horario, la respuesta está aquí.

**Resultado esperado:** la issue **#3** abierta, con tu descripción y `luis` como asignado en la barra lateral derecha.

> [!TIP]
> Si tu issue tiene otro número, usa ese número en lugar de `3` en el resto del lab.

### 5 — Crea la rama con el número de la issue (luis)

**Acción:** en tu copia local:

```bash
git switch -c 3-horario-verano
```

**Por qué:** empezar el nombre por `3-` dice a cualquiera, y a GitLab, qué issue resuelve la rama.

**Resultado esperado:**

```console
Switched to a new branch '3-horario-verano'
```

> [!NOTE]
> También se puede crear desde la web: en la issue #3, el desplegable del botón **Create merge request** tiene la opción **Create branch**. GitLab propone un nombre que empieza por `3-` a partir del título. Si la creas así, haz `git fetch` y `git switch` con ese nombre en lugar del comando de arriba.

### 6 — Haz el cambio (luis)

**Acción:** abre `docs/normas-de-trabajo.md` en VS Code y, en «## Horario», debajo de la línea del horario de referencia, añade una línea en blanco y esta:

```markdown
Del 1 de julio al 31 de agosto, el horario es de 8:00 a 15:00.
```

Guarda y comprueba con `git diff`.

**Por qué:** es justo lo que pide la issue, y nada más: una MR pequeña se revisa mejor.

**Resultado esperado:**

```diff
@@ -4,6 +4,8 @@
 
 El horario de referencia es de 9:00 a 17:00, con flexibilidad de una hora a la entrada.
 
+Del 1 de julio al 31 de agosto, el horario es de 8:00 a 15:00.
+
 ## Reuniones
```

### 7 — Registra el commit (luis)

**Acción:**

```bash
git add docs/normas-de-trabajo.md
git commit -m "Añade el horario de verano (#3)"
```

**Por qué:** `#3` en el mensaje enlaza el commit con la issue: desde GitLab se llega de uno a otro.

**Resultado esperado:**

```console
[3-horario-verano e5bf0b1] Añade el horario de verano (#3)
 1 file changed, 2 insertions(+)
```

### 8 — Publica la rama (luis)

**Acción:**

```bash
git push -u origin 3-horario-verano
```

**Por qué:** `main` está protegida, pero las demás ramas no: como Developer puedes subir la tuya.

**Resultado esperado:** la rama se crea en GitLab y la respuesta trae el enlace para abrir la merge request:

```console
remote:
remote: To create a merge request for 3-horario-verano, visit:
remote:   https://gitlab.ejemplo.com/ana/manual-m04-issue/-/merge_requests/new?merge_request%5Bsource_branch%5D=3-horario-verano
remote:
To https://gitlab.ejemplo.com/ana/manual-m04-issue.git
 * [new branch]      3-horario-verano -> 3-horario-verano
branch '3-horario-verano' set up to track 'origin/3-horario-verano'.
```

### 9 — Abre la merge request (luis)

**Acción:**
1. Abre el enlace del push (<kbd>Ctrl</kbd> + clic en la terminal de VS Code).
2. Comprueba que el origen es `3-horario-verano` y el destino `main`.
3. **Title:** `Añade el horario de verano`.
4. **Description:** asegúrate de que contiene la línea `Closes #3` (GitLab puede haberla puesto ya por el nombre de la rama).
5. En **Reviewer**, elige a `ana`.
6. Deja marcada **Delete source branch when merge request is accepted.**
7. Pulsa **Create merge request**.

**Por qué:** la MR es la propuesta formal de que el cambio entre en `main`. `Closes #3` hace que la issue se cierre sola al fusionar, y el revisor sabe que le toca a él.

**Resultado esperado:** la MR **!1** abierta, con origen `3-horario-verano`, destino `main`, `ana` como revisora y, en la descripción, `Closes #3` convertido en enlace a la issue.

### 10 — Recorre la relación issue ↔ rama ↔ MR (luis)

**Acción:**
1. Abre la issue #3 (**Plan → Issues**).
2. Busca la MR relacionada en el cuerpo de la issue y en su actividad.
3. Desde la MR, pulsa la pestaña **Commits** y luego **Code → Branches**.

**Por qué:** en un equipo, la pregunta «¿en qué va esto?» se responde desde la issue: ahí está la MR, y desde la MR, la rama y sus commits.

**Resultado esperado:** la issue #3 muestra la MR !1 como relacionada y, en la actividad, que la mencionó el commit o la MR. La MR muestra el commit `Añade el horario de verano (#3)`. En **Code → Branches** aparece `3-horario-verano` junto a `main`.

## Comprueba tu entendimiento

**La issue sigue abierta**
`ana`: abre **Plan → Issues**.
→ La #3 sigue **Open**: no se cierra hasta que se fusione la MR.

**Qué cambia la MR**
`ana`: abre la MR !1 y la pestaña **Changes**.
→ Un fichero, `docs/normas-de-trabajo.md`, con dos líneas añadidas.

**main intacta**
`ana`: abre **Code → Repository** en la rama `main` y mira `docs/normas-de-trabajo.md`.
→ Aún no aparece el horario de verano.

## Reto

### 1 — Una issue desde la propia issue

Toma la issue #2 («Falta el canal del chat del equipo en Herramientas») y resuélvela sin crear la rama a mano: crea la rama y la MR desde la propia issue y haz el cambio en la web.

<details>
<summary>Ver solución</summary>

En la issue #2, pulsa **Create merge request**. GitLab crea una rama que empieza por `2-` y una MR en borrador que ya cierra la #2. Desde la MR, edita `docs/herramientas.md` en esa rama (por ejemplo, con **Code → Repository**, eligiendo la rama y **Edit**), añade el canal a la fila «Chat del equipo» y guarda el commit en esa misma rama. La MR muestra el cambio en **Changes**.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| `luis` recibe `Repository not found` o 404 al clonar | No es miembro del proyecto o la URL es otra | `ana` revisa **Manage → Members**; la URL es `ana/manual-m04-issue` |
| `Authentication failed` al clonar o hacer push | Escribiste la contraseña de GitLab en lugar del token | Usa tu token de acceso personal como contraseña |
| `You are not allowed to push code to protected branches` | Hiciste el commit en `main` en vez de en tu rama | `git switch -c 3-horario-verano` (el commit viaja contigo) y vuelve a hacer push de la rama |
| La issue no se enlaza con la MR | En la descripción falta `Closes #3` o tiene otro número | Edita la MR y añade `Closes #3` con el número real de la issue |
| La issue de `luis` no es la #3 | No se crearon las dos issues del paso 2, o se crearon más | Usa el número real en la rama, el commit y `Closes` |
