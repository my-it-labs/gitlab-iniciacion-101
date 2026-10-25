# Lab — .gitignore

[← Página anterior](03-lab-publicar-y-comparar.md) · [Siguiente página →](../M03-ramas-y-conflictos/README.md)

Mientras Ana trabaja en el proyecto, en su carpeta aparecen archivos que no son del proyecto: sus notas, las copias de seguridad que deja el editor, los ajustes de VS Code. Si se cuelan en un `git add .`, acaban en GitLab para todo el equipo. En este lab los excluyes con un `.gitignore` y resuelves el caso de un archivo que ya se había subido por error.

### Objetivo

Un `.gitignore` publicado en `manual-m02-gitignore` que excluye `notas-personales.txt`, las copias `*~` y la carpeta `.vscode/`, y `.vscode/settings.json` fuera del repositorio aunque se hubiera versionado antes.

### Punto de partida

- El entorno de prácticas levantado ([El entorno de prácticas](../../infra/README.md)).
- No hace falta nada de páginas anteriores: el paso 1 crea `ana/manual-m02-gitignore` en GitLab, lo clona en `~/trabajo/manual-m02-gitignore` del ordenador de Ana y deja allí su identidad de Git y su clave SSH.

### En qué consiste

Creas tres archivos locales, los ves aparecer en `git status`, escribes el `.gitignore` y compruebas con `git status` y `git check-ignore -v` que ya no aparecen. Después reproduces un archivo versionado por error y lo sacas del repositorio con `git rm --cached` sin borrarlo del ordenador de Ana.

### 1 — Prepara el punto de partida y entra en el ordenador de Ana

**Acción:**

```bash
# 🖥️ Terminal del Codespace
scripts/partida.sh ana manual-m02-gitignore
docker exec -it pc-ana bash
```

```bash
# 💻 Ordenador de Ana
cd ~/trabajo/manual-m02-gitignore
```

**Por qué:** una copia local limpia del proyecto, sin `.gitignore`, sin depender de otro lab.

**Resultado esperado:** el script acaba con `Copia local: ~/trabajo/manual-m02-gitignore en el ordenador de ana (pc-ana)` y el prompt es `ana@pc-ana:~/trabajo/manual-m02-gitignore$`. `git status` dice `nothing to commit, working tree clean`.

### 2 — Crea las notas personales de Ana

**Acción** (📝 VS Code, ordenador de Ana): crea el archivo `home-ana/trabajo/manual-m02-gitignore/notas-personales.txt`, en la raíz del proyecto, con la línea `Preguntar a Luis por el acceso al chat`, y guarda.

**Por qué:** son apuntes de Ana sobre el proyecto. Le viene bien tenerlos en la carpeta, pero no son del equipo.

**Resultado esperado:** en el explorador, `notas-personales.txt` aparece junto a `README.md`, `docs/` y `scripts/`, marcado con una `U`: Git lo ve, pero no lo sigue.

### 3 — Crea una copia de seguridad del editor

**Acción** (📝 VS Code, ordenador de Ana): en `home-ana/trabajo/manual-m02-gitignore/docs/`, copia `bienvenida.md` (clic derecho → **Copy** y después **Paste** en la misma carpeta) y renombra la copia a `borrador.md~`, con la virgulilla al final.

**Por qué:** muchos editores dejan copias con `~` al final del nombre. Aquí se crea a mano para tener una.

**Resultado esperado:** `docs/` contiene `bienvenida.md`, `borrador.md~`, `herramientas.md` y `normas-de-trabajo.md`.

### 4 — Crea los ajustes de VS Code

**Acción** (📝 VS Code, ordenador de Ana): crea la carpeta `home-ana/trabajo/manual-m02-gitignore/.vscode/` y, dentro, el archivo `settings.json` con este contenido; guarda:

```json
{ "editor.wordWrap": "on" }
```

**Por qué:** VS Code, si alguien abre el proyecto con él, guarda en `.vscode/` los ajustes de su editor. Cada persona tiene los suyos; aquí se crean a mano para tener unos.

**Resultado esperado:** la carpeta `.vscode/` con `settings.json` en la raíz del proyecto.

### 5 — Mira lo que Git ve

**Acción** (💻 Ordenador de Ana): `git status`

**Por qué:** antes de excluir nada, comprueba que Git ofrece añadir los tres al repositorio.

**Resultado esperado:**

```text
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.vscode/
	docs/borrador.md~
	notas-personales.txt

nothing added to commit but untracked files present (use "git add" to track)
```

Un `git add .` ahora los metería los tres en el próximo commit.

### 6 — Escribe el .gitignore

**Acción** (📝 VS Code, ordenador de Ana): crea el archivo `home-ana/trabajo/manual-m02-gitignore/.gitignore`, en la raíz del proyecto (junto a `README.md`), con estas tres líneas, y guarda:

```gitignore
notas-personales.txt
*~
.vscode/
```

**Por qué:** cada línea es un patrón. `notas-personales.txt` excluye ese archivo; `*~` cualquier nombre que acabe en `~`, en cualquier carpeta; `.vscode/` la carpeta entera con todo lo que tenga dentro.

**Resultado esperado:** en el explorador de VS Code, `notas-personales.txt`, `borrador.md~` y `.vscode/` pasan a verse atenuados: VS Code lee el mismo `.gitignore` que Git.

### 7 — Comprueba el estado

**Acción** (💻 Ordenador de Ana): `git status`

**Por qué:** los archivos ignorados desaparecen de la lista. El `.gitignore` en cambio sí aparece, porque es un archivo más del proyecto y se comparte con el equipo.

**Resultado esperado:**

```text
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.gitignore

nothing added to commit but untracked files present (use "git add" to track)
```

### 8 — Averigua qué regla ignora cada archivo

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
git check-ignore -v notas-personales.txt docs/borrador.md~ .vscode/settings.json
```

**Por qué:** cuando un `.gitignore` crece, `check-ignore -v` te dice qué línea de qué archivo ignora cada ruta. Es como depuras un patrón que no hace lo que esperas.

**Resultado esperado:**

```text
.gitignore:1:notas-personales.txt	notas-personales.txt
.gitignore:2:*~	docs/borrador.md~
.gitignore:3:.vscode/	.vscode/settings.json
```

Formato: `archivo:línea:patrón` y la ruta. Con un archivo que no se ignora, como `git check-ignore -v docs/bienvenida.md`, no sale nada.

### 9 — Registra y publica el .gitignore

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
git add .gitignore
git commit -m "Ignora notas personales, copias de seguridad y ajustes del editor"
git push
```

**Por qué:** al estar en el repositorio, el `.gitignore` protege a todo el que clone el proyecto, no solo a Ana.

**Resultado esperado:**

```text
[main e2c7178] Ignora notas personales, copias de seguridad y ajustes del editor
 1 file changed, 3 insertions(+)
 create mode 100644 .gitignore
```

y el `push` acaba con `main -> main`. En GitLab, **Code** → **Repository** muestra `.gitignore` y no muestra ninguno de los tres archivos.

### 10 — Reproduce un archivo versionado por error

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
git add -f .vscode/settings.json
git commit -m "Añade los ajustes del editor"
```

**Por qué:** simula lo que pasa a menudo: alguien subió `.vscode/settings.json` antes de que existiera el `.gitignore`. `-f` obliga a añadir un archivo ignorado.

**Resultado esperado:**

```text
[main 5523530] Añade los ajustes del editor
 1 file changed, 1 insertion(+)
 create mode 100644 .vscode/settings.json
```

### 11 — Comprueba que el .gitignore ya no lo protege

**Acción** (💻 Ordenador de Ana):
1. En VS Code (📝), abre `home-ana/trabajo/manual-m02-gitignore/.vscode/settings.json`, cambia `"on"` por `"off"` y guarda.
2. Ejecuta `git status`.
3. Ejecuta `git check-ignore -v .vscode/settings.json`.

**Por qué:** `.gitignore` solo actúa sobre archivos sin seguimiento. Un archivo que ya está en un commit se sigue vigilando, aunque un patrón lo cubra.

**Resultado esperado:** `git status` muestra el archivo como modificado:

```text
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   .vscode/settings.json
```

y `git check-ignore -v` no imprime nada: para Git, un archivo versionado no está ignorado.

### 12 — Sácalo del repositorio sin borrarlo

**Acción** (💻 Ordenador de Ana): `git rm --cached .vscode/settings.json` y después `git status`.

**Por qué:** `--cached` lo quita del repositorio pero deja el archivo en el disco de Ana. Sin `--cached`, `git rm` también lo borraría de su carpeta.

**Resultado esperado:**

```text
rm '.vscode/settings.json'
```

```text
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	deleted:    .vscode/settings.json
```

### 13 — Registra la salida y publícala

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
git commit -m "Deja de versionar los ajustes del editor"
git push
```

**Por qué:** el commit registra que el archivo deja de estar en el repositorio. A partir de aquí, el `.gitignore` vuelve a cubrirlo.

**Resultado esperado:**

```text
[main 4b6e093] Deja de versionar los ajustes del editor
 1 file changed, 1 deletion(-)
 delete mode 100644 .vscode/settings.json
```

y el `push` acaba con `main -> main`. En VS Code, `.vscode/settings.json` sigue en la carpeta de Ana (ahora atenuado, porque vuelve a estar ignorado), `git status` dice `nothing to commit, working tree clean` y `git check-ignore -v .vscode/settings.json` vuelve a responder `.gitignore:3:.vscode/	.vscode/settings.json`.

> [!WARNING]
> El archivo sigue en los commits antiguos: cualquiera puede verlo en el historial. Si un archivo con una contraseña o un token llega a GitLab, sacarlo con `git rm --cached` no basta: hay que cambiar esa contraseña o revocar el token.

## Comprueba tu entendimiento

**Un archivo ignorado no se añade por despiste**
Ejecuta `git add notas-personales.txt`.
→ Git se niega:

```text
The following paths are ignored by one of your .gitignore files:
notas-personales.txt
hint: Use -f if you really want to add them.
```

**El repositorio no tiene los archivos locales**
Ejecuta `git ls-files`.
→ Lista `.gitignore`, `README.md`, las tres páginas de `docs/` y los dos scripts. No aparecen `notas-personales.txt`, `docs/borrador.md~` ni nada de `.vscode/`.

## Reto

### 1 — Archivos temporales en cualquier carpeta

El script de construcción podría dejar archivos `.tmp` en cualquier carpeta del proyecto. Añade una regla al `.gitignore` que los excluya y compruébala con `docs/copia.tmp`.

<details>
<summary>Ver solución</summary>

Añade al `.gitignore` la línea `*.tmp`. Después, crea en VS Code un archivo vacío `home-ana/trabajo/manual-m02-gitignore/docs/copia.tmp` y comprueba:

```bash
# 💻 Ordenador de Ana
git check-ignore -v docs/copia.tmp
```

Responde `.gitignore:4:*.tmp	docs/copia.tmp`. Un patrón sin `/` se aplica en cualquier carpeta. Haz commit del `.gitignore` con un mensaje como «Ignora los archivos temporales».

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| Un archivo sigue apareciendo en `git status` con el `.gitignore` escrito | El archivo ya estaba versionado | `git rm --cached <archivo>` y commit (pasos 12 y 13) |
| El `.gitignore` no tiene efecto | Está guardado en otra carpeta o con otro nombre (`gitignore` sin punto, `.gitignore.txt`) | Debe llamarse exactamente `.gitignore` y estar en la raíz del proyecto, junto a `README.md` |
| `git check-ignore -v` no imprime nada | La ruta no la cubre ningún patrón, o el archivo está versionado | Revisa el patrón; con `git ls-files <archivo>` sabrás si está versionado |
| `git rm` borró el archivo de la carpeta | Faltó `--cached` | `git restore --staged <archivo>` y `git restore <archivo>` lo recuperan si aún no hiciste commit |
