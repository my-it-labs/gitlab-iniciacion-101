# Lab — Commits

[← Página anterior](01-lab-clonar.md) · [Siguiente página →](03-lab-publicar-y-comparar.md)

En el manual del equipo cambian a la vez cosas que no tienen nada que ver: una norma de vacaciones y una herramienta nueva. Si las guardas juntas, dentro de un tiempo nadie sabrá por qué cambió cada una ni podrá deshacer una sin la otra. En este lab registras cada cambio en su propio commit, con un mensaje que explica qué cambia en el manual.

### Objetivo

Dos commits nuevos en `~/trabajo/manual-m02-commits`, uno por cambio, cada uno con un solo archivo y un mensaje claro.

### Punto de partida

- Repo del curso descargado en tu equipo y una terminal abierta en su carpeta (Git Bash en Windows).
- Instancia de GitLab del curso: `https://gitlab.ejemplo.com`; usuario `ana` (usa el tuyo) y token de acceso personal con los scopes `api` y `write_repository` (se crea en [Lab — Identidad y acceso](../M01-introduccion-git-gitlab/01-lab-identidad-y-acceso.md)).
- Git configurado con tu nombre y correo (`git config --global user.name` y `user.email`).
- Estado: el paso 1 crea `ana/manual-m02-commits` en GitLab y lo clona en `~/trabajo/manual-m02-commits`.

### En qué consiste

Cambias dos páginas por motivos distintos y las registras en dos commits separados con `git add <archivo>` y `git commit -m`, mirando `git status` entre paso y paso. No publicas nada en GitLab: eso es el [Lab — Publicar y comparar](03-lab-publicar-y-comparar.md).

### 1 — Prepara el punto de partida

**Acción:** en la carpeta del repo del curso:

```bash
scripts/partida.sh manual-m02-commits
cd ~/trabajo/manual-m02-commits
```

**Por qué:** te deja una copia local limpia del manual, con tres commits de historial, sin depender de otro lab.

**Resultado esperado:** el script termina con `Copia local: ` seguido de la ruta de `~/trabajo/manual-m02-commits`. Dentro, `git status` dice `nothing to commit, working tree clean`.

### 2 — Cambia la norma de vacaciones

**Acción:** abre el proyecto con `code .`. En `docs/normas-de-trabajo.md`, bajo `## Vacaciones`, cambia `dos semanas` por `tres semanas` y guarda. La línea queda así:

```markdown
Se solicitan con tres semanas de antelación a tu responsable.
```

**Por qué:** es el primer cambio: una norma del equipo que se ha endurecido.

**Resultado esperado:** VS Code marca `normas-de-trabajo.md` con una `M`.

### 3 — Añade VS Code a las herramientas

**Acción:** en `docs/herramientas.md`, añade esta fila al final de la tabla, justo debajo de la de GitLab, y guarda:

```markdown
| VS Code | Editar las páginas del manual | Instálalo desde el portal de software |
```

**Por qué:** es el segundo cambio, sin relación con el primero. Ahora tienes los dos pendientes a la vez, como pasa en el trabajo real.

**Resultado esperado:** VS Code marca también `herramientas.md` con una `M`.

### 4 — Mira el estado con los dos cambios

**Acción:** `git status`

**Por qué:** antes de preparar nada, comprueba qué hay pendiente. Así decides qué entra en cada commit.

**Resultado esperado:**

```text
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   docs/herramientas.md
	modified:   docs/normas-de-trabajo.md

no changes added to commit (use "git add" and/or "git commit -a")
```

### 5 — Prepara solo la norma de vacaciones

**Acción:** `git add docs/normas-de-trabajo.md` y después `git status`.

**Por qué:** `git add` con el nombre del archivo elige qué entra en el próximo commit. El otro cambio se queda esperando.

**Resultado esperado:**

```text
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   docs/normas-de-trabajo.md

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   docs/herramientas.md
```

Cada archivo está en un bloque distinto: `normas-de-trabajo.md` preparado, `herramientas.md` solo modificado.

### 6 — Haz el primer commit

**Acción:**

```bash
git commit -m "Amplía a tres semanas el preaviso de vacaciones"
```

**Por qué:** el mensaje explica qué cambia en el manual. Quien lea el historial sabrá qué pasó sin abrir el archivo.

**Resultado esperado:**

```text
[main c9dc0fa] Amplía a tres semanas el preaviso de vacaciones
 1 file changed, 1 insertion(+), 1 deletion(-)
```

`1 file changed`: solo ha entrado la norma de vacaciones. Tu identificador (`c9dc0fa`) será otro.

### 7 — Comprueba qué queda pendiente

**Acción:** `git status`

**Por qué:** confirma que el commit se llevó solo lo preparado y que el cambio de herramientas sigue esperando.

**Resultado esperado:**

```text
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   docs/herramientas.md

no changes added to commit (use "git add" and/or "git commit -a")
```

`ahead of 'origin/main' by 1 commit`: tienes un commit que GitLab aún no tiene.

### 8 — Prepara las herramientas

**Acción:** `git add docs/herramientas.md`

**Por qué:** ahora le toca al segundo cambio.

**Resultado esperado:** `git status` muestra `modified:   docs/herramientas.md` bajo `Changes to be committed:` y nada más pendiente.

### 9 — Haz el segundo commit

**Acción:**

```bash
git commit -m "Añade VS Code a las herramientas"
```

**Por qué:** cada cambio queda con su propio mensaje y se podrá revisar o deshacer por separado.

**Resultado esperado:**

```text
[main 01f0a99] Añade VS Code a las herramientas
 1 file changed, 1 insertion(+)
```

### 10 — Revisa el resultado

**Acción:** `git status` y después `git log --oneline`

**Por qué:** cierras comprobando que no queda nada pendiente y que el historial cuenta los dos cambios por separado.

**Resultado esperado:**

```text
On branch main
Your branch is ahead of 'origin/main' by 2 commits.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
```

```text
01f0a99 Añade VS Code a las herramientas
c9dc0fa Amplía a tres semanas el preaviso de vacaciones
9d174d9 Añade normas de trabajo y scripts de validación
bb8d16b Añade bienvenida y herramientas
6265460 Crea el manual del equipo
```

## Comprueba tu entendimiento

**Un archivo por commit**
Ejecuta `git log --stat -2`.
→ Cada uno de los dos commits nuevos lista un solo archivo: `docs/herramientas.md | 1 +` en el de VS Code y `docs/normas-de-trabajo.md | 2 +-` en el de vacaciones, los dos con `Author: Ana <ana@equipo.local>`.

**Los commits son locales**
Abre el proyecto en GitLab y mira **Code** → **Commits**.
→ El último sigue siendo «Añade normas de trabajo y scripts de validación». Tus dos commits solo están en tu equipo hasta que hagas `git push`.

## Reto

### 1 — Commit sin preparar

Cambia en `README.md` la frase «Todo lo que necesita saber una persona que se incorpora al equipo.» por otra y, sin hacer `git add`, ejecuta `git commit -m "Reescribe la presentación del manual"`. ¿Qué pasa y por qué?

<details>
<summary>Ver solución</summary>

No se crea ningún commit. Git responde con el estado y termina así:

```text
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
```

`git commit` guarda solo lo que está en el área de preparación, y está vacía. Haz `git add README.md` y repite el commit.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| `Author identity unknown` … `Please tell me who you are.` | Git no tiene tu nombre y correo | `git config --global user.name "Ana"` y `git config --global user.email "ana@equipo.local"` (con tus datos) y repite el commit |
| El commit dice `2 files changed` | Usaste `git add .`, que prepara todo lo que ha cambiado | `git reset --soft HEAD~1` deshace el commit dejando los cambios preparados; luego `git restore --staged docs/herramientas.md` y vuelve al paso 6 |
| Al hacer `git commit` se abre un editor en la terminal | Faltaba `-m "mensaje"` y Git abre el editor para que lo escribas | En Vim: <kbd>Esc</kbd>, escribe `:q!` y <kbd>Enter</kbd>; repite con `-m` |
| `nothing to commit, working tree clean` | Ya hiciste el commit o no guardaste el archivo en VS Code | `git log --oneline` para ver si está; si no, guarda el archivo y repite `git add` |
