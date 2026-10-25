# Control de versiones y las tres áreas

[← Página anterior](README.md) · [Siguiente página →](01-lab-identidad-y-acceso.md)

El proyecto vive en una carpeta compartida: si alguien cambia el horario de `docs/normas-de-trabajo.md`, nadie sabe quién lo hizo, cuándo ni cuál era el texto anterior. Esta demostración ocurre entera en el ordenador de Ana: convierte su copia del proyecto en un repositorio Git y sigue un único cambio, el horario, por las tres áreas de Git: desde que se edita hasta que queda guardado en un commit. Al final se ve qué parte de ese recorrido es Git y qué añade GitLab.

## Punto de partida

- El entorno de prácticas levantado ([El entorno de prácticas](../../infra/README.md)). Todo se hace en el ordenador de Ana:

```bash
# 🖥️ Terminal del Codespace
docker exec -it pc-ana bash
```

- Git con la identidad de Ana. Si su ordenador aún no la tiene (se configura en el [lab de identidad y acceso](01-lab-identidad-y-acceso.md)):

```bash
# 💻 Ordenador de Ana
git config --global user.name "Ana"
git config --global user.email "ana@equipo.local"
git config --global init.defaultBranch main
```

- Una copia del proyecto, sin Git todavía, en el ordenador de Ana (📝 VS Code): en el explorador, la carpeta `proyecto/manual-equipo` del repositorio del curso se copia dentro de `home-ana/trabajo/` (se crea `trabajo` si no existe) y la copia se renombra a `manual-tres-areas`. Desde ese momento está en el ordenador de Ana, en `~/trabajo/manual-tres-areas`:

```bash
# 💻 Ordenador de Ana
cd ~/trabajo/manual-tres-areas
```

- No hace falta GitLab: todo el recorrido ocurre en el ordenador de Ana.

## Las tres áreas

Git reparte cada archivo entre tres sitios, y todo el recorrido consiste en mover un cambio de uno a otro:

| Área | Qué es | Cómo entra un cambio |
|------|--------|----------------------|
| **Directorio de trabajo** | Los archivos tal como se ven y se editan en la carpeta | Editando con cualquier programa |
| **Área de preparación** (*staging*) | La lista de cambios elegidos para el próximo commit | `git add` |
| **Repositorio** | La carpeta `.git/`: el historial de commits guardados | `git commit` |

```text
directorio de trabajo ──git add──▶ área de preparación ──git commit──▶ repositorio
```

## Recorrido

### 1. La carpeta se convierte en repositorio

`git init` crea la carpeta oculta `.git/`, que es el **repositorio**, la tercera área: ahí se guardarán los commits.

```bash
# 💻 Ordenador de Ana
git init
```

```text
Initialized empty Git repository in /home/ana/trabajo/manual-tres-areas/.git/
```

`git status` describe en qué área está cada archivo. Recién creado el repositorio, todo el proyecto está en el **directorio de trabajo** y Git todavía no lo sigue (*untracked*):

```text
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.gitlab-ci.yml
	README.md
	docs/
	scripts/

nothing added to commit but untracked files present (use "git add" to track)
```

### 2. Primera foto del proyecto

Con `git add .` todo el proyecto pasa al área de preparación, y `git commit` guarda la primera foto:

```bash
# 💻 Ordenador de Ana
git add .
git commit -m "Crea el manual del equipo"
```

```text
[main (root-commit) 8e56976] Crea el manual del equipo
 7 files changed, 106 insertions(+)
 create mode 100644 .gitlab-ci.yml
 create mode 100644 README.md
 create mode 100644 docs/bienvenida.md
 create mode 100644 docs/herramientas.md
 create mode 100644 docs/normas-de-trabajo.md
 create mode 100755 scripts/construir.sh
 create mode 100755 scripts/validar.sh
```

`8e56976` es el identificador abreviado del commit. Ese estado del proyecto ya se puede recuperar siempre.

### 3. Un cambio en el directorio de trabajo

En `docs/normas-de-trabajo.md`, la línea del horario pasa de 9:00 a 17:00 a 8:30 a 16:30. Ana abre en VS Code `home-ana/trabajo/manual-tres-areas/docs/normas-de-trabajo.md`, cambia la línea y guarda; Git no interviene. `git status` lo detecta como modificado y **no preparado** (*not staged*):

```text
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   docs/normas-de-trabajo.md

no changes added to commit (use "git add" and/or "git commit -a")
```

`git diff` enseña exactamente qué ha cambiado respecto a la última foto: la línea con `-` es la que había y la línea con `+` es la nueva.

```text
diff --git a/docs/normas-de-trabajo.md b/docs/normas-de-trabajo.md
index db74ebd..8a08d1c 100644
--- a/docs/normas-de-trabajo.md
+++ b/docs/normas-de-trabajo.md
@@ -2,7 +2,7 @@
 
 ## Horario
 
-El horario de referencia es de 9:00 a 17:00, con flexibilidad de una hora a la entrada.
+El horario de referencia es de 8:30 a 16:30, con flexibilidad de una hora a la entrada.
 
 ## Reuniones
 
```

### 4. El cambio pasa al área de preparación

`git add` elige qué irá en el próximo commit. Aquí solo hay un archivo, pero con varios cambios a medias se podría preparar uno y dejar el resto para después.

```bash
# 💻 Ordenador de Ana
git add docs/normas-de-trabajo.md
```

```text
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   docs/normas-de-trabajo.md

```

El mensaje ha cambiado de *Changes not staged* a *Changes to be committed*: el archivo está en el **área de preparación**.

### 5. El commit guarda la foto en el repositorio

```bash
# 💻 Ordenador de Ana
git commit -m "Adelanta el horario de referencia"
```

```text
[main 9185d1c] Adelanta el horario de referencia
 1 file changed, 1 insertion(+), 1 deletion(-)
```

Ahora `git status` ya no tiene nada que contar, y el historial tiene dos commits:

```text
On branch main
nothing to commit, working tree clean
```

```text
9185d1c Adelanta el horario de referencia
8e56976 Crea el manual del equipo
```

`git log -1` muestra lo que la carpeta compartida no sabía responder: quién, cuándo y por qué.

```text
commit 9185d1c0db042054517e85173cdb35e8c9854988
Author: Ana <ana@equipo.local>
Date:   Sun Oct 25 10:02:17 2026 +0100

    Adelanta el horario de referencia
```

### 6. Dónde entra GitLab

Todo lo anterior ha ocurrido sin red: es Git, en el ordenador de Ana. El repositorio solo existe en `~/trabajo/manual-tres-areas/.git/` de `pc-ana`, y Luis, desde su ordenador, no ve el cambio de horario. GitLab entra cuando ese repositorio se sube a un servidor común:

| Lo que se ha visto aquí (Git, local) | Lo que añade GitLab (servidor) |
|---------------------------------------|--------------------------------|
| `git init`, `git add`, `git commit`, `git log` | Una copia remota del repositorio que comparte el equipo |
| Historial con autor, fecha y mensaje | El mismo historial, navegable en la web (**Code** → **Commits**) |
| Una sola persona en su ordenador | Miembros con roles y permisos (**Manage** → **Members**) |
| — | Issues, merge requests y pipelines que validan cada cambio |

## Qué queda visto

Un cambio recorre tres áreas: se edita en el directorio de trabajo, `git add` lo lleva al área de preparación y `git commit` lo guarda en el repositorio con autor, fecha y mensaje. `git status` dice en cada momento en qué área está cada archivo. Que el commit lleve el nombre correcto depende de la identidad configurada en Git: se configura en [01 — Lab — Identidad y acceso](01-lab-identidad-y-acceso.md), que se puede hacer sin haber seguido esta demostración.
