# Lab — Clonar

[← Página anterior](00-ciclo-de-un-cambio.md) · [Siguiente página →](02-lab-commits.md)

`manual-equipo` vive en GitLab, pero para editarlo Ana necesita una copia en su ordenador enlazada con el proyecto. En este lab clonas el proyecto por SSH en `~/trabajo/` del ordenador de Ana y aprendes a leer `git status`, la orden que dice en cada momento qué páginas se han tocado y en qué estado están.

### Objetivo

Tener `~/trabajo/manual-m02-clonar` clonado desde GitLab en el ordenador de Ana y saber reconocer en `git status` un archivo sin seguimiento y uno modificado.

### Punto de partida

- El entorno de prácticas levantado ([El entorno de prácticas](../../infra/README.md)): GitLab en `http://localhost:8080`, cuenta `ana` con contraseña `Formacion-2026!`.
- No hace falta nada de páginas anteriores: el paso 1 crea el proyecto y deja el ordenador de Ana con su identidad de Git y su clave SSH registrada.

### En qué consiste

Creas el proyecto de partida, copias su dirección SSH en GitLab, lo clonas en el ordenador de Ana y lees su estado. Después creas una página nueva y editas otra para ver cómo cambia `git status`. No haces ningún commit: eso es el [Lab — Commits](02-lab-commits.md).

### 1 — Crea el proyecto de partida

**Acción:**

```bash
# 🖥️ Terminal del Codespace
scripts/partida.sh ana manual-m02-clonar --solo-remoto
```

**Por qué:** deja en el espacio de Ana un `manual-equipo` con contenido e historial. Con `--solo-remoto` no lo clona, porque clonarlo es lo que vas a practicar.

**Resultado esperado:**

```text
Creando ana/manual-m02-clonar en GitLab…
Proyecto: http://localhost:8080/ana/manual-m02-clonar
```

Si el ordenador de Ana aún no tenía identidad de Git o clave SSH, salen además líneas que dicen que se han configurado.

### 2 — Copia la dirección SSH

**Acción** (🌐 GitLab, sesión de Ana):
1. Abre `http://localhost:8080/ana/manual-m02-clonar`.
2. Pulsa el botón **Code** (arriba a la derecha, sobre la lista de archivos).
3. En **Clone with SSH**, pulsa el icono de copiar.

**Por qué:** es la dirección con la que Git se conecta al proyecto desde el ordenador de Ana. Con SSH no hay contraseña: GitLab reconoce a Ana por su clave.

**Resultado esperado:** tienes en el portapapeles `git@gitlab:ana/manual-m02-clonar.git`. La página del proyecto muestra `README.md`, `docs/` y `scripts/`, y arriba el último commit, «Añade normas de trabajo y scripts de validación».

> 📷 **Captura pendiente** · `M02-01-clone-ssh.png` — GitLab, sesión de Ana: desplegable **Code** con **Clone with SSH**.

### 3 — Entra en el ordenador de Ana

**Acción:**

```bash
# 🖥️ Terminal del Codespace
docker exec -it pc-ana bash
```

**Por qué:** el clon tiene que estar en el ordenador de quien va a editar. A partir de aquí, todo lo que escribas en esta terminal lo hace Ana.

**Resultado esperado:** el prompt `ana@pc-ana:~$`.

### 4 — Ve a la carpeta de trabajo

**Acción:**

```bash
# 💻 Ordenador de Ana
cd ~/trabajo
```

**Por qué:** `git clone` crea la carpeta del proyecto dentro de donde estés. Tener todas las copias en `~/trabajo/` evita clonar un repositorio dentro de otro.

**Resultado esperado:** el prompt `ana@pc-ana:~/trabajo$`.

### 5 — Clona el proyecto

**Acción:** escribe `git clone `, pega la dirección y pulsa <kbd>Enter</kbd>:

```bash
# 💻 Ordenador de Ana
git clone git@gitlab:ana/manual-m02-clonar.git
```

**Por qué:** el proyecto es privado, así que GitLab comprueba quién eres: lo hace con la clave SSH de Ana, sin preguntar nada. `clone` descarga el repositorio entero, con todo su historial, y lo deja enlazado con GitLab.

**Resultado esperado:**

```text
Cloning into 'manual-m02-clonar'...
remote: Enumerating objects: 15, done.
remote: Total 15 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (15/15), done.
Resolving deltas: 100% (2/2), done.
```

Las cifras pueden variar algo. Lo que importa es que no aparece ninguna línea `fatal:`.

### 6 — Entra y mira el historial

**Acción:**

```bash
# 💻 Ordenador de Ana
cd manual-m02-clonar
git log --oneline
```

**Por qué:** la carpeta clonada no es solo una copia de los archivos: trae también los commits. Ana puede ver el historial sin conexión con GitLab.

**Resultado esperado:** en el explorador de VS Code aparece `home-ana/trabajo/manual-m02-clonar/` con `README.md`, `docs/` y `scripts/`: el clon está en el ordenador de Ana. En la terminal, el historial:

```text
d8a5d05 Añade normas de trabajo y scripts de validación
84f3f2f Añade bienvenida y herramientas
4a7be77 Crea el manual del equipo
```

Tus identificadores serán otros; los tres mensajes, los mismos.

### 7 — Comprueba el enlace con GitLab

**Acción:**

```bash
# 💻 Ordenador de Ana
git remote -v
```

**Por qué:** `clone` ha guardado la dirección del proyecto con el nombre `origin`. Es adonde irán los `push` de Ana y de donde vendrán sus `pull`.

**Resultado esperado:**

```text
origin	git@gitlab:ana/manual-m02-clonar.git (fetch)
origin	git@gitlab:ana/manual-m02-clonar.git (push)
```

### 8 — Lee el estado recién clonado

**Acción:**

```bash
# 💻 Ordenador de Ana
git status
```

**Por qué:** es la foto de partida: nada cambiado. A partir de aquí, cada vez que dudes de qué has tocado, `git status` te lo dice.

**Resultado esperado:**

```text
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

`working tree clean` significa que los archivos son idénticos al último commit.

### 9 — Crea una página nueva

**Acción** (📝 VS Code, ordenador de Ana): crea el archivo `home-ana/trabajo/manual-m02-clonar/docs/glosario.md` con este contenido y guarda:

```markdown
# Glosario

- **MR**: merge request, la petición para integrar un cambio.
```

Después, en el ordenador de Ana (💻), ejecuta `git status`.

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

### 10 — Modifica una página existente

**Acción** (📝 VS Code, ordenador de Ana): en `home-ana/trabajo/manual-m02-clonar/docs/normas-de-trabajo.md`, sección `## Horario`, cambia `de 9:00 a 17:00` por `de 8:30 a 16:30` y guarda. Después, en el ordenador de Ana (💻), ejecuta `git status`.

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

VS Code también lo ve: en el explorador, `glosario.md` aparece con una `U` (sin seguimiento) y `normas-de-trabajo.md` con una `M` (modificado). Es la misma información que `git status`, porque VS Code lee el mismo repositorio.

### 11 — Usa la versión corta

**Acción:**

```bash
# 💻 Ordenador de Ana
git status -s
```

**Por qué:** cuando ya sabes leer `git status`, la versión corta te da lo mismo en una línea por archivo.

**Resultado esperado:**

```text
 M docs/normas-de-trabajo.md
?? docs/glosario.md
```

`??` es sin seguimiento; `M` en la segunda columna, modificado y aún no preparado.

## Comprueba tu entendimiento

**Del estado sin seguimiento al preparado**
En el ordenador de Ana, ejecuta `git add docs/glosario.md` y después `git status -s`.
→ Sale `A  docs/glosario.md` (la `A` en la primera columna: preparado como archivo nuevo) y ` M docs/normas-de-trabajo.md` sin cambios. En `git status`, el glosario ha pasado al bloque `Changes to be committed:` como `new file:   docs/glosario.md`.

**Nada ha llegado a GitLab**
Recarga la página del proyecto en GitLab (sesión de Ana).
→ No hay `docs/glosario.md` y el horario sigue siendo de 9:00 a 17:00. Sin commit y sin `push`, GitLab no sabe nada de los cambios de Ana.

## Reto

### 1 — Deshaz el cambio del horario sin el editor

Deja `docs/normas-de-trabajo.md` exactamente como estaba en el último commit sin editarlo a mano. Pista: `git status` te dice cómo.

<details>
<summary>Ver solución</summary>

```bash
# 💻 Ordenador de Ana
git restore docs/normas-de-trabajo.md
git status -s
```

`git restore` no imprime nada. Después `git status -s` ya no muestra `normas-de-trabajo.md` (el glosario sigue, porque es otro archivo). Cuidado: lo que deshace `git restore` no se puede recuperar.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| `Ya existe ana/manual-m02-clonar en GitLab. Usa otro nombre, p. ej. manual-m02-clonar-2` | Ya ejecutaste `partida.sh` con ese nombre | Usa el proyecto que ya tienes o ejecuta `scripts/partida.sh ana manual-m02-clonar-2 --solo-remoto` |
| `git@gitlab: Permission denied (publickey).` al clonar | La clave de Ana no está registrada en su perfil de GitLab | Vuelve a ejecutar el paso 1 con otro nombre de proyecto (registra la clave) o regístrala como en el [lab de identidad y acceso](../M01-introduccion-git-gitlab/01-lab-identidad-y-acceso.md) |
| `bash: git: command not found` o el prompt no es `ana@pc-ana` | Estás en el terminal del Codespace, no en el ordenador de Ana | `docker exec -it pc-ana bash` |
| `fatal: destination path 'manual-m02-clonar' already exists and is not an empty directory.` | Ya hay una carpeta con ese nombre en `~/trabajo` | Entra en ella si es el mismo proyecto, o clona con otro nombre: `git clone <url> manual-m02-clonar-2` |
| `fatal: not a git repository` | Estás en `~/trabajo` y no dentro de la carpeta del proyecto | `cd ~/trabajo/manual-m02-clonar` |
| `git status` no muestra `docs/glosario.md` | El archivo no se guardó, o se creó en otra carpeta (por ejemplo, fuera de `home-ana/`) | Comprueba en el explorador que está en `home-ana/trabajo/manual-m02-clonar/docs/` y que no tiene el punto de «sin guardar» |
