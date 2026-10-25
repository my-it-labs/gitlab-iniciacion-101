# Lab — Clonar

[← Página anterior](00-ciclo-de-un-cambio.md) · [Siguiente página →](02-lab-commits.md)

`manual-equipo` vive en GitLab, pero para editarlo con VS Code necesitas una copia en tu equipo enlazada con el proyecto. En este lab clonas el manual en `~/trabajo/` y aprendes a leer `git status`, la orden que te dice en cada momento qué páginas has tocado y en qué estado están.

### Objetivo

Tener `~/trabajo/manual-m02-clonar` clonado desde GitLab y saber reconocer en `git status` un archivo sin seguimiento y uno modificado.

### Punto de partida

- Repo del curso descargado en tu equipo y una terminal abierta en su carpeta (Git Bash en Windows).
- Instancia de GitLab del curso: `https://gitlab.ejemplo.com` (la dirección real te la da el formador).
- Usuario `ana` (usa el tuyo) y un token de acceso personal con los scopes `api` y `write_repository`. Si no lo tienes, créalo como en [Lab — Identidad y acceso](../M01-introduccion-git-gitlab/01-lab-identidad-y-acceso.md).
- Git configurado con tu nombre y correo (`git config --global user.name` y `user.email`).
- Estado: el paso 1 crea el proyecto `ana/manual-m02-clonar` en GitLab, sin copia local.

### En qué consiste

Creas el proyecto de partida, copias su URL de clonado en GitLab, lo clonas y lees su estado. Después creas una página nueva y editas otra para ver cómo cambia `git status`. No haces ningún commit: eso es el [Lab — Commits](02-lab-commits.md).

### 1 — Crea el proyecto de partida

**Acción:** en la carpeta del repo del curso, ejecuta:

```bash
scripts/partida.sh manual-m02-clonar --solo-remoto
```

La primera vez te pide la URL de GitLab y tu token, y los guarda en `~/.curso-gitlab`.

**Por qué:** te deja en GitLab un `manual-equipo` con contenido e historial, igual para toda la clase. Con `--solo-remoto` no lo clona, porque clonarlo es lo que vas a practicar.

**Resultado esperado:**

```text
Creando ana/manual-m02-clonar en GitLab…
Proyecto: https://gitlab.ejemplo.com/ana/manual-m02-clonar
```

### 2 — Copia la URL de clonado

**Acción:**
1. Abre en el navegador `https://gitlab.ejemplo.com/ana/manual-m02-clonar`.
2. Pulsa el botón **Code** (arriba a la derecha, sobre la lista de archivos).
3. En **Clone with HTTPS**, pulsa el icono de copiar.

**Por qué:** es la dirección con la que Git se conecta al proyecto. En el curso se usa HTTPS con token; la de **Clone with SSH** necesita una clave SSH que aquí no se configura.

**Resultado esperado:** tienes en el portapapeles `https://gitlab.ejemplo.com/ana/manual-m02-clonar.git`. La página del proyecto muestra `README.md`, `docs/` y `scripts/`, y arriba el último commit, «Añade normas de trabajo y scripts de validación».

### 3 — Ve a tu carpeta de trabajo

**Acción:**

```bash
mkdir -p ~/trabajo
cd ~/trabajo
```

**Por qué:** `git clone` crea la carpeta del proyecto dentro de donde estés. Tener todas las copias en `~/trabajo/` evita clonar un repositorio dentro de otro.

**Resultado esperado:** `pwd` muestra tu carpeta personal seguida de `/trabajo`.

### 4 — Clona el proyecto

**Acción:** escribe `git clone `, pega la URL y pulsa <kbd>Enter</kbd>:

```bash
git clone https://gitlab.ejemplo.com/ana/manual-m02-clonar.git
```

Cuando te lo pida, escribe tu usuario (`ana`) y, como contraseña, el token.

**Por qué:** el proyecto es privado, así que GitLab comprueba quién eres. `clone` descarga el repositorio entero, con todo su historial, y lo deja enlazado con GitLab.

**Resultado esperado:**

```text
Cloning into 'manual-m02-clonar'...
Username for 'https://gitlab.ejemplo.com': ana
Password for 'https://ana@gitlab.ejemplo.com':
remote: Enumerating objects: 15, done.
remote: Total 15 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (15/15), done.
Resolving deltas: 100% (2/2), done.
```

Las cifras pueden variar algo. Lo que importa es que no aparece ninguna línea `fatal:`.

> [!TIP]
> En Windows, Git Credential Manager puede abrir una ventana para iniciar sesión en lugar de preguntar en la terminal. Elige la opción de token o de usuario y contraseña y pega el token.

### 5 — Entra y mira el historial

**Acción:**

```bash
cd manual-m02-clonar
ls
git log --oneline
```

**Por qué:** la carpeta clonada no es solo una copia de los archivos: trae también los commits. Puedes ver el historial sin conexión con GitLab.

**Resultado esperado:**

```text
README.md  docs  scripts
```

```text
d8a5d05 Añade normas de trabajo y scripts de validación
84f3f2f Añade bienvenida y herramientas
4a7be77 Crea el manual del equipo
```

Tus identificadores serán otros; los tres mensajes, los mismos.

### 6 — Comprueba el enlace con GitLab

**Acción:** `git remote -v`

**Por qué:** `clone` ha guardado la dirección del proyecto con el nombre `origin`. Es adonde irán tus `push` y de donde vendrán tus `pull`.

**Resultado esperado:**

```text
origin	https://gitlab.ejemplo.com/ana/manual-m02-clonar.git (fetch)
origin	https://gitlab.ejemplo.com/ana/manual-m02-clonar.git (push)
```

### 7 — Lee el estado recién clonado

**Acción:** `git status`

**Por qué:** es la foto de partida: nada cambiado. A partir de aquí, cada vez que dudes de qué has tocado, `git status` te lo dice.

**Resultado esperado:**

```text
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

`working tree clean` significa que tus archivos son idénticos al último commit.

### 8 — Crea una página nueva

**Acción:**
1. Abre el proyecto en VS Code: `code .`
2. Crea el archivo `docs/glosario.md` con este contenido y guárdalo:

   ```markdown
   # Glosario

   - **MR**: merge request, la petición para integrar un cambio.
   ```

3. En la terminal, ejecuta `git status`.

**Por qué:** un archivo nuevo no forma parte del repositorio hasta que se lo dices a Git. Mientras tanto está **sin seguimiento**.

**Resultado esperado:**

```text
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	docs/glosario.md

nothing added to commit but untracked files present (use "git add" to track)
```

### 9 — Modifica una página existente

**Acción:**
1. En VS Code, abre `docs/normas-de-trabajo.md`.
2. En `## Horario`, cambia `de 9:00 a 17:00` por `de 8:30 a 16:30` y guarda.
3. Ejecuta `git status`.

**Por qué:** este archivo ya está en el repositorio, así que Git lo compara con el último commit y detecta que ha cambiado: está **modificado**.

**Resultado esperado:**

```text
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   docs/normas-de-trabajo.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	docs/glosario.md

no changes added to commit (use "git add" and/or "git commit -a")
```

En el explorador de VS Code, `glosario.md` aparece con una `U` (untracked) y `normas-de-trabajo.md` con una `M` (modified).

### 10 — Usa la versión corta

**Acción:** `git status -s`

**Por qué:** cuando ya sabes leer `git status`, la versión corta te da lo mismo en una línea por archivo.

**Resultado esperado:**

```text
 M docs/normas-de-trabajo.md
?? docs/glosario.md
```

`??` es sin seguimiento; `M` en la segunda columna, modificado y aún no preparado.

## Comprueba tu entendimiento

**Del estado sin seguimiento al preparado**
Ejecuta `git add docs/glosario.md` y después `git status -s`.
→ Sale `A  docs/glosario.md` (la `A` en la primera columna: preparado como archivo nuevo) y ` M docs/normas-de-trabajo.md` sin cambios. En `git status`, el glosario ha pasado al bloque `Changes to be committed:` como `new file:   docs/glosario.md`.

**Nada ha llegado a GitLab**
Recarga la página del proyecto en GitLab.
→ No hay `docs/glosario.md` y el horario sigue siendo de 9:00 a 17:00. Sin commit y sin `push`, GitLab no sabe nada de tus cambios.

## Reto

### 1 — Deshaz el cambio del horario sin el editor

Deja `docs/normas-de-trabajo.md` exactamente como estaba en el último commit sin abrir VS Code. Pista: `git status` te dice cómo.

<details>
<summary>Ver solución</summary>

```bash
git restore docs/normas-de-trabajo.md
git status -s
```

`git restore` no imprime nada. Después `git status -s` ya no muestra `normas-de-trabajo.md` (el glosario sigue, porque es otro archivo). Cuidado: lo que deshace `git restore` no se puede recuperar.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| `Ya existe ana/manual-m02-clonar en GitLab. Usa otro nombre, p. ej. manual-m02-clonar-2` | Ya ejecutaste `partida.sh` con ese nombre | Usa el proyecto que ya tienes o ejecuta `scripts/partida.sh manual-m02-clonar-2 --solo-remoto` |
| `fatal: Authentication failed` al clonar | Escribiste tu contraseña de GitLab en lugar del token, o el token ha caducado | Vuelve a clonar y pega el token como contraseña; si caducó, crea otro en GitLab |
| `fatal: destination path 'manual-m02-clonar' already exists and is not an empty directory.` | Ya hay una carpeta con ese nombre en `~/trabajo` | Entra en ella si es el mismo proyecto, o clona con otro nombre: `git clone <url> manual-m02-clonar-2` |
| `fatal: not a git repository` | Estás en `~/trabajo` y no dentro de la carpeta del proyecto | `cd ~/trabajo/manual-m02-clonar` |
| `git status` no muestra `docs/glosario.md` | El archivo no se ha guardado o se creó en otra carpeta | Guarda con <kbd>Ctrl</kbd>+<kbd>S</kbd> y comprueba que está en `docs/` del proyecto clonado |
