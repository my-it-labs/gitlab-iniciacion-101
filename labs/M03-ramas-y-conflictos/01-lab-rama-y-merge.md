# Lab — Rama y merge

[← Página anterior](00-ramas-como-punteros.md) · [Siguiente página →](02-lab-conflicto.md)

El proyecto necesita una página de preguntas frecuentes. Mientras Ana la escribe, `main` tiene que seguir mostrando el documento completo y sin páginas a medias, y alguien puede seguir corrigiendo otras páginas en `main`. En este lab, en el ordenador de Ana, escribes la página en su propia rama, la fusionas cuando está lista y publicas el resultado en GitLab.

### Objetivo

Un `main` en GitLab con la página `docs/preguntas-frecuentes.md` enlazada desde el `README.md`, integrada con un commit de merge, y la rama de trabajo ya borrada.

### Punto de partida

- El entorno de prácticas levantado ([El entorno de prácticas](../../infra/README.md)).
- Estado: en el terminal del Codespace, ejecuta:

  ```bash
  # 🖥️ Terminal del Codespace
  scripts/partida.sh ana manual-m03-ramas
  docker exec -it pc-ana bash
  ```

  Crea `ana/manual-m03-ramas` en GitLab con el contenido del proyecto y tres commits en `main`, lo clona en `~/trabajo/manual-m03-ramas` del ordenador de Ana y deja allí su identidad de Git y su clave SSH. El segundo comando te sienta en el ordenador de Ana.

### En qué consiste

Creas la rama `pagina-faq`, haces en ella dos commits (la página nueva y su enlace en el índice), vuelves a `main` y haces allí un commit en otra página. Así las dos ramas tienen trabajo propio y la fusión crea un commit de merge. Terminas borrando la rama y publicando `main`. No usas merge requests: eso es el M04.

### 1 — Mira el grafo de partida

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
cd ~/trabajo/manual-m03-ramas
git log --oneline --graph --all
```

**Por qué:** es la foto de partida. Vas a repetir este comando después de cada paso para ver cómo se mueven los nombres de las ramas.

**Resultado esperado:** tres commits en línea; `main` y `origin/main` apuntan al último:

```text
* a915cab (HEAD -> main, origin/main, origin/HEAD) Añade normas de trabajo y scripts de validación
* 54bcf5a Añade bienvenida y herramientas
* 31ce040 Crea el manual del equipo
```

Los identificadores (`a915cab`…) serán otros en tu proyecto.

### 2 — Crea la rama y cámbiate a ella

**Acción** (💻 Ordenador de Ana): `git switch -c pagina-faq`

**Por qué:** a partir de aquí, los commits de Ana avanzan `pagina-faq` y dejan `main` donde está. La página a medias no llega al proyecto publicado.

**Resultado esperado:**

```text
Switched to a new branch 'pagina-faq'
```

Compruébalo con `git branch`: el asterisco marca la rama actual.

```text
  main
* pagina-faq
```

### 3 — Crea la página de preguntas frecuentes

**Acción** (📝 VS Code, ordenador de Ana): crea `home-ana/trabajo/manual-m03-ramas/docs/preguntas-frecuentes.md` con este contenido y guarda:

```markdown
# Preguntas frecuentes

## ¿Dónde pido acceso a GitLab?

A soporte, como indica la página de [herramientas](herramientas.md).

## ¿Puedo cambiar mi horario?

Hay una hora de flexibilidad a la entrada. Lo tienes en las [normas de trabajo](normas-de-trabajo.md).
```

**Por qué:** la primera línea es el título que exige `scripts/validar.sh`, y los enlaces apuntan a páginas que existen en `docs/`.

**Resultado esperado:** `git status` muestra la página como archivo nuevo sin seguimiento, en la rama `pagina-faq`:

```text
On branch pagina-faq
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	docs/preguntas-frecuentes.md

nothing added to commit but untracked files present (use "git add" to track)
```

### 4 — Confirma la página

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
git add docs/preguntas-frecuentes.md
git commit -m "Añade la página de preguntas frecuentes"
```

**Por qué:** un commit para la página y otro para el enlace: cada uno se entiende solo en el historial.

**Resultado esperado:** el commit queda en la rama `pagina-faq` (lo dice el corchete):

```text
[pagina-faq 9bc5423] Añade la página de preguntas frecuentes
 1 file changed, 9 insertions(+)
 create mode 100644 docs/preguntas-frecuentes.md
```

### 5 — Enlaza la página desde el índice

**Acción** (📝 VS Code, ordenador de Ana): en `home-ana/trabajo/manual-m03-ramas/README.md`, en la lista de **Páginas**, añade debajo de `- [Normas de trabajo](docs/normas-de-trabajo.md)` la línea:

```markdown
- [Preguntas frecuentes](docs/preguntas-frecuentes.md)
```

Guarda y revisa el cambio en el ordenador de Ana (💻) con `git diff`.

**Por qué:** una página que nadie enlaza no se encuentra. El índice del `README.md` es la puerta de entrada al proyecto.

**Resultado esperado:**

```text
@@ -7,6 +7,7 @@ Todo lo que necesita saber una persona que se incorpora al equipo.
 - [Bienvenida](docs/bienvenida.md)
 - [Herramientas](docs/herramientas.md)
 - [Normas de trabajo](docs/normas-de-trabajo.md)
+- [Preguntas frecuentes](docs/preguntas-frecuentes.md)
 
 ## Cómo se mantiene
```

### 6 — Confirma el enlace y valida

**Acción** (💻 Ordenador de Ana):

```bash
# 💻 Ordenador de Ana
git commit -am "Enlaza las preguntas frecuentes desde el índice"
sh scripts/validar.sh
```

**Por qué:** antes de fusionar, comprueba en la rama que el proyecto sigue siendo válido. Si algo falla, se arregla aquí sin afectar a `main`.

**Resultado esperado:** el commit en `pagina-faq` y la validación en verde, ya con la página nueva:

```text
[pagina-faq 8496533] Enlaza las preguntas frecuentes desde el índice
 1 file changed, 1 insertion(+)
```

```text
revisado README.md
revisado docs/bienvenida.md
revisado docs/herramientas.md
revisado docs/normas-de-trabajo.md
revisado docs/preguntas-frecuentes.md
Todas las páginas son correctas
```

Con `git log --oneline --graph --all`, `pagina-faq` va dos commits por delante de `main`:

```text
* 8496533 (HEAD -> pagina-faq) Enlaza las preguntas frecuentes desde el índice
* 9bc5423 Añade la página de preguntas frecuentes
* a915cab (origin/main, origin/HEAD, main) Añade normas de trabajo y scripts de validación
* 54bcf5a Añade bienvenida y herramientas
* 31ce040 Crea el manual del equipo
```

### 7 — Vuelve a `main`

**Acción** (💻 Ordenador de Ana): `git switch main`. Después mira en VS Code la carpeta `home-ana/trabajo/manual-m03-ramas/docs/`.

**Por qué:** cambiar de rama cambia los archivos de la carpeta. En `main` la página nueva todavía no existe: es la prueba de que el trabajo está aislado.

**Resultado esperado:**

```text
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
```

En el explorador de VS Code, `docs/` solo tiene `bienvenida.md`, `herramientas.md` y `normas-de-trabajo.md`: `preguntas-frecuentes.md` ha desaparecido de la carpeta de Ana. No se ha borrado: sigue en la rama `pagina-faq`, y vuelve si haces `git switch pagina-faq`.

### 8 — Haz un commit en `main`

**Acción** (📝 VS Code, ordenador de Ana): en `home-ana/trabajo/manual-m03-ramas/docs/bienvenida.md`, en **Primer día**, añade al final de la lista y guarda:

```markdown
- Configura Git con tu nombre y tu correo del equipo.
```

Después, en el ordenador de Ana (💻), confírmalo:

```bash
# 💻 Ordenador de Ana
git commit -am "Añade la configuración de Git al primer día"
```

**Por qué:** simula lo que pasa en un equipo: mientras la página se escribía en su rama, alguien ha mejorado otra en `main`. Ahora las dos ramas tienen commits propios.

**Resultado esperado:** con `git log --oneline --graph --all` ves la bifurcación:

```text
* 123b93e (HEAD -> main) Añade la configuración de Git al primer día
| * 8496533 (pagina-faq) Enlaza las preguntas frecuentes desde el índice
| * 9bc5423 Añade la página de preguntas frecuentes
|/  
* a915cab (origin/main, origin/HEAD) Añade normas de trabajo y scripts de validación
* 54bcf5a Añade bienvenida y herramientas
* 31ce040 Crea el manual del equipo
```

### 9 — Fusiona la rama en `main`

**Acción** (💻 Ordenador de Ana): estando en `main`, ejecuta `git merge --no-edit pagina-faq`.

**Por qué:** `git merge` trae a la rama actual los commits de la otra. Como las dos han avanzado, Git no puede limitarse a mover el puntero: crea un commit de merge que une las dos historias. `--no-edit` acepta el mensaje que propone Git, `Merge branch 'pagina-faq'`, sin abrir un editor.

**Resultado esperado:**

```text
Merge made by the 'ort' strategy.
 README.md                    | 1 +
 docs/preguntas-frecuentes.md | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 docs/preguntas-frecuentes.md
```

### 10 — Mira el commit de merge

**Acción** (💻 Ordenador de Ana): `git log --oneline --graph --all`

**Por qué:** el grafo enseña lo que ha hecho el merge: un commit con dos padres que junta la rama y el trabajo de `main`.

**Resultado esperado:**

```text
*   9ca98f2 (HEAD -> main) Merge branch 'pagina-faq'
|\  
| * 8496533 (pagina-faq) Enlaza las preguntas frecuentes desde el índice
| * 9bc5423 Añade la página de preguntas frecuentes
* | 123b93e Añade la configuración de Git al primer día
|/  
* a915cab (origin/main, origin/HEAD) Añade normas de trabajo y scripts de validación
* 54bcf5a Añade bienvenida y herramientas
* 31ce040 Crea el manual del equipo
```

En VS Code, `docs/` ya tiene `preguntas-frecuentes.md`, y `docs/bienvenida.md` conserva la línea del paso 8.

### 11 — Borra la rama fusionada

**Acción** (💻 Ordenador de Ana): `git branch -d pagina-faq` y después `git branch`.

**Por qué:** su trabajo ya está en `main`. Borrar la rama solo quita el nombre, no los commits, y evita que se acumulen ramas que ya no dicen nada.

**Resultado esperado:**

```text
Deleted branch pagina-faq (was 8496533).
```

```text
* main
```

### 12 — Publica `main`

**Acción** (💻 Ordenador de Ana): `git push`

**Por qué:** hasta ahora todo está en el ordenador de Ana. El push sube a GitLab los cuatro commits nuevos: los dos de la rama, el de `main` y el de merge.

**Resultado esperado:** la salida termina con:

```text
To gitlab:ana/manual-m03-ramas.git
   a915cab..9ca98f2  main -> main
```

En GitLab (sesión de Ana), **Code → Repository graph** dibuja la misma bifurcación y unión que la terminal, y **Code → Repository** muestra `docs/preguntas-frecuentes.md`. En **Code → Branches** solo está `main`: la rama `pagina-faq` nunca se subió.

> 📷 **Captura pendiente** · `M03-01-repository-graph.png` — GitLab, sesión de Ana: **Code → Repository graph** con la bifurcación y el commit de merge.

## Comprueba tu entendimiento

**El commit de merge tiene dos padres**
Ejecuta `git log -1 --format=%P`.
→ Dos identificadores: el de «Añade la configuración de Git al primer día» y el de «Enlaza las preguntas frecuentes desde el índice».

**Local y GitLab coinciden**
Ejecuta `git status`.
→ `Your branch is up to date with 'origin/main'.` y `nothing to commit, working tree clean`.

**La página está publicada**
En GitLab (sesión de Ana), abre `README.md` en **Code → Repository** y pulsa el enlace **Preguntas frecuentes**.
→ Se abre `docs/preguntas-frecuentes.md` con el título «Preguntas frecuentes».

## Reto

### 1 — Una fusión sin commit de merge

Crea la rama `pagina-glosario`, añade en ella `docs/glosario.md` (con título `# Glosario`) en un commit y fusiónala en `main` sin hacer antes ningún commit en `main`. ¿Qué dice `git merge` y qué forma tiene el grafo?

<details>
<summary>Ver solución</summary>

```bash
# 💻 Ordenador de Ana
git switch -c pagina-glosario
# en VS Code: crea home-ana/trabajo/manual-m03-ramas/docs/glosario.md con «# Glosario»
git add docs/glosario.md
git commit -m "Añade el glosario"
git switch main
git merge --no-edit pagina-glosario
```

Como `main` no ha cambiado desde que se creó la rama, la salida dice `Fast-forward` y no se abre ningún editor: Git solo mueve `main` al commit del glosario. El grafo sigue en línea recta y no hay commit «Merge branch…». Termina con `git branch -d pagina-glosario` y `git push`.

</details>

### 2 — Borrar una rama sin fusionar

Crea la rama `prueba`, haz un commit en ella, vuelve a `main` e intenta borrarla con `git branch -d prueba`. ¿Qué pasa y por qué?

<details>
<summary>Ver solución</summary>

Git se niega:

```text
error: the branch 'prueba' is not fully merged
hint: If you are sure you want to delete it, run 'git branch -D prueba'
```

`-d` solo borra ramas cuyo trabajo ya está en la rama actual, para no perder commits por despiste. Si de verdad quieres descartar ese trabajo, `git branch -D prueba` la borra igualmente.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| El commit de la página sale como `[main …]` | La página se creó sin cambiar de rama | Comprueba la rama con `git branch` antes de confirmar. Si ya está en `main`, crea la rama ahí (`git switch -c pagina-faq`) y sigue: el commit va con ella |
| `error: Your local changes to the following files would be overwritten by checkout` al hacer `git switch` | Hay cambios sin confirmar en un archivo que es distinto en la otra rama | Confírmalos (`git commit -am "…"`) o deshazlos (`git restore <archivo>`) y vuelve a cambiar de rama |
| `git merge` termina con `Fast-forward` y no hay commit de merge | No hiciste el commit en `main` del paso 8 | No es un error: la página está fusionada. El commit de merge solo aparece si `main` ha avanzado |
| Tras `git merge` la terminal se llena con un editor de texto | Faltó `--no-edit` y Git abre su editor para el mensaje del merge | Sal con **Ctrl+X**; el merge se completa con el mensaje propuesto |
| `error: cannot delete branch 'pagina-faq' used by worktree at …` | Intentas borrar la rama en la que estás | `git switch main` y repite `git branch -d pagina-faq` |
| `error: the branch 'pagina-faq' is not fully merged` | Intentas borrarla antes de fusionarla | Desde `main`, fusiona con `git merge pagina-faq` y bórrala después |
| `git merge pagina-faq` responde `Already up to date.` | Estás en `pagina-faq` en vez de en `main` | `git switch main` y repite el merge |
