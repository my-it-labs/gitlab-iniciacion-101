# Lab — Proyecto compartido

[← Página anterior](00-roles-issues-y-mr.md) · [Siguiente página →](02-lab-de-issue-a-mr.md)

El manual del equipo deja de ser cosa de una sola persona: tu pareja va a escribir en él contigo. En este lab, la dueña del proyecto da acceso a su pareja con el rol justo y protege `main` para que ningún cambio entre en el manual sin pasar por una merge request.

### Objetivo

`luis` es miembro de `ana/manual-m04-compartido` con rol Developer, y nadie (ni siquiera `ana`) puede hacer push directo a `main`.

### Punto de partida

- Instancia de GitLab del curso: `https://gitlab.ejemplo.com` (la URL real te la da el formador).
- Trabajáis por parejas. En esta página, **`ana`** es la dueña del proyecto y **`luis`** su pareja. Usa vuestros usuarios reales donde ponga `ana` y `luis`. Si sois tres, la tercera persona hace lo mismo que `luis`.
- Cada uno con su token de acceso personal (scopes `api` y `write_repository`) y su identidad de Git configurada.
- Estado: lo crea `ana` en el paso 1. No hace falta haber hecho ninguna página anterior.

### En qué consiste

`ana` crea el proyecto, invita a `luis` y protege `main`. Después los dos comprobáis que la protección funciona: un push directo rechazado y una merge request que `luis` no puede fusionar. No se revisa ni se fusiona nada: eso está en [03 — Revisión](03-lab-revision.md).

### 1 — Crea el proyecto (ana)

**Acción:** en una terminal, desde la carpeta del repo del curso:

```bash
scripts/partida.sh manual-m04-compartido
```

Si es la primera vez que lo ejecutas, pide la URL de GitLab y tu token.

**Por qué:** deja un `manual-equipo` con historial en tu namespace y una copia local, sin depender de labs anteriores.

**Resultado esperado:** el script termina con:

```console
Proyecto: https://gitlab.ejemplo.com/ana/manual-m04-compartido
Copia local: /home/ana/trabajo/manual-m04-compartido
```

### 2 — Invita a tu pareja (ana)

**Acción:**
1. Abre `https://gitlab.ejemplo.com/ana/manual-m04-compartido`.
2. En la barra lateral, ve a **Manage → Members**.
3. Pulsa **Invite members**.
4. En el campo de usuario escribe `luis` y elígelo en la lista.
5. En el desplegable de rol elige **Developer**.
6. Pulsa **Invite**.

**Por qué:** el proyecto es privado; sin ser miembro, `luis` ni siquiera lo ve. Developer es el rol de quien escribe en el manual: puede crear ramas y abrir merge requests, pero no cambiar la configuración del proyecto.

**Resultado esperado:** en **Manage → Members**, la lista muestra a `ana` (Owner) y a `luis` con el rol **Developer**.

### 3 — Comprueba el acceso (luis)

**Acción:** entra en GitLab con tu usuario y abre `https://gitlab.ejemplo.com/ana/manual-m04-compartido`.

**Por qué:** confirmas que la invitación ha llegado a la persona correcta antes de configurar nada más.

**Resultado esperado:** ves el proyecto, con `README.md`, `docs/` y `scripts/`. En la barra lateral no aparece **Settings → Repository**: con rol Developer no puedes cambiar la configuración.

Lo que cada uno puede hacer en este proyecto, en resumen:

| Acción en `manual-m04-compartido` | `ana` (Owner) | `luis` (Developer) |
|-----------------------------------|:-------------:|:------------------:|
| Crear issues y ramas, abrir MR | Sí | Sí |
| Push a una rama nueva | Sí | Sí |
| Invitar miembros y proteger ramas | Sí | No |
| Fusionar en `main` (tras el paso 4) | Sí | No |
| Push directo a `main` (tras el paso 4) | No | No |

### 4 — Protege `main` (ana)

**Acción:**
1. Ve a **Settings → Repository**.
2. Despliega la sección **Protected branches** (botón **Expand**).
3. En la fila de `main`, deja **Allowed to merge** en **Maintainers**.
4. En la misma fila, cambia **Allowed to push and merge** a **No one**.

**Por qué:** GitLab ya protege `main` al crearla, pero deja hacer push a los Maintainers, así que la dueña podría saltarse la revisión. Con **No one**, el único camino a `main` es una merge request, y solo los Maintainers la fusionan.

**Resultado esperado:** la fila de `main` muestra **Allowed to merge: Maintainers** y **Allowed to push and merge: No one**. El cambio se guarda al elegirlo en el desplegable.

> [!WARNING]
> La protección tarda un momento en aplicarse. Si el push del paso siguiente entra, espera un poco y repítelo con otro cambio.

### 5 — Intenta un push directo a `main` (ana)

**Acción:** en tu copia local, cambia la línea del horario en `docs/normas-de-trabajo.md` y súbela directamente a `main`:

```bash
cd ~/trabajo/manual-m04-compartido
sed -i 's/flexibilidad de una hora/flexibilidad de hora y media/' docs/normas-de-trabajo.md
git commit -am "Amplía la flexibilidad de entrada"
git push
```

**Por qué:** es la prueba de que la protección funciona también para quien la puso.

**Resultado esperado:** el commit se crea en local, pero GitLab rechaza el push:

```console
[main 4c2e065] Amplía la flexibilidad de entrada
 1 file changed, 1 insertion(+), 1 deletion(-)
```

```console
remote: GitLab: You are not allowed to push code to protected branches on this project.
To https://gitlab.ejemplo.com/ana/manual-m04-compartido.git
 ! [remote rejected] main -> main (pre-receive hook declined)
error: failed to push some refs to 'https://gitlab.ejemplo.com/ana/manual-m04-compartido.git'
```

En **Code → Commits** de GitLab, el último commit sigue siendo «Añade normas de trabajo y scripts de validación».

### 6 — Lleva el cambio a una rama (ana)

**Acción:**

```bash
git switch -c flexibilidad-entrada
git switch main
git reset --hard origin/main
git push -u origin flexibilidad-entrada
```

**Por qué:** el commit rechazado no se pierde: la rama nueva lo conserva, y `main` local vuelve a coincidir con la de GitLab. Así es como entra el trabajo cuando `main` está protegida.

**Resultado esperado:** al volver a `main`, Git avisa de que va un commit por delante (`Your branch is ahead of 'origin/main' by 1 commit.`); el `reset` lo deja como en GitLab (`HEAD is now at …`). El push de la rama entra y GitLab sugiere el enlace para crear la merge request:

```console
 * [new branch]      flexibilidad-entrada -> flexibilidad-entrada
branch 'flexibilidad-entrada' set up to track 'origin/flexibilidad-entrada'.
```

`git status` en `main` dice `Your branch is up to date with 'origin/main'.`

### 7 — Abre la merge request (ana)

**Acción:**
1. Abre el enlace que mostró el push (o **Code → Merge requests → New merge request**, con origen `flexibilidad-entrada` y destino `main`).
2. Deja el título que propone GitLab.
3. Pulsa **Create merge request**.

**Por qué:** es la MR con la que `luis` comprobará qué no puede hacer.

**Resultado esperado:** la MR **!1** abierta, con origen `flexibilidad-entrada` y destino `main`. En tu pestaña **Overview** aparece el botón **Merge**.

### 8 — Comprueba que no puedes fusionar (luis)

**Acción:** abre **Code → Merge requests** en `ana/manual-m04-compartido` y entra en la MR !1.

**Por qué:** como Developer puedes leer, comentar y revisar, pero **Allowed to merge: Maintainers** te deja fuera de la fusión. Es lo que garantiza que el cambio lo integra alguien con responsabilidad sobre `main`.

**Resultado esperado:** ves el diff y puedes comentar, pero no tienes botón **Merge**: el bloque de fusión indica que solo pueden fusionar los miembros con permiso sobre la rama de destino.

## Comprueba tu entendimiento

**Rol de la pareja**
`ana`: abre **Manage → Members**.
→ `luis` aparece con rol **Developer**.

**Protección de `main`**
`ana`: abre **Settings → Repository → Protected branches**.
→ `main`: **Allowed to merge: Maintainers**, **Allowed to push and merge: No one**.

**Push directo de la pareja**
`luis`: clona el proyecto (`git clone https://gitlab.ejemplo.com/ana/manual-m04-compartido.git ~/trabajo/manual-m04-compartido`, con tu usuario y tu token), haz un commit en `main` y `git push`.
→ El mismo rechazo que en el paso 5: `You are not allowed to push code to protected branches on this project.`

## Reto

### 1 — Una rama para la pareja

Sin cambiar la protección de `main`, consigue que `luis` publique su commit del apartado anterior y que llegue a una MR que pueda fusionar `ana`.

<details>
<summary>Ver solución</summary>

`luis` mueve su commit a una rama y la sube:

```bash
git switch -c vacaciones-calendario
git push -u origin vacaciones-calendario
```

Las ramas que no son `main` no están protegidas, así que un Developer puede hacer push. Después abre la MR desde el enlace del push; `ana` la ve con el botón **Merge** y `luis` no.

</details>

### 2 — El rol que no basta

¿Qué pasaría si hubieras invitado a `luis` como **Reporter**? Compruébalo cambiando su rol en **Manage → Members** y pidiéndole que haga push de una rama nueva.

<details>
<summary>Ver solución</summary>

Un Reporter lee el código y crea issues, pero no puede hacer push a ninguna rama: GitLab rechaza el push con un mensaje de que no tiene permiso para subir código al proyecto. Vuelve a ponerlo como **Developer** al terminar.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| `luis` no aparece al invitarlo | Escribiste el nombre con otra forma o no existe en la instancia | Busca por su usuario exacto de GitLab; pídele que mire su perfil |
| `luis` ve «404» al abrir el proyecto | Aún no es miembro o abrió otra URL | Revisa **Manage → Members** y que la URL sea `ana/manual-m04-compartido` |
| No ves **Settings → Repository** | Estás con la cuenta de `luis` (Developer) | La protección la configura la dueña del proyecto |
| El push del paso 5 entra en `main` | La protección aún no se había aplicado, o quedó **Allowed to push and merge: Maintainers** | Revisa la fila de `main`, espera un momento y repite con otro commit |
| `Ya existe ana/manual-m04-compartido en GitLab` | Ya ejecutaste el script con ese nombre | Usa `scripts/partida.sh manual-m04-compartido-2` |
| Tras el paso 6, `git push` en `main` vuelve a fallar | Olvidaste `git reset --hard origin/main` y el commit sigue en `main` local | Ejecútalo en `main` (el commit ya está a salvo en `flexibilidad-entrada`) |
