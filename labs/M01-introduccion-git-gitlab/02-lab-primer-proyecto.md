# Lab — Primer proyecto

[← Página anterior](01-lab-identidad-y-acceso.md) · [Siguiente página →](../M02-operaciones-basicas/README.md)

El manual del equipo necesita un sitio común donde todos vean la misma versión y su historial. En este lab creas el proyecto `manual-equipo` en la instancia de GitLab del curso, recorres las secciones que usarás en el resto del curso y haces tu primer commit sin salir del navegador.

### Objetivo

El proyecto `ana/manual-equipo` creado con su `README.md`, editado desde la web, y dos commits visibles en **Code** → **Commits**.

### Punto de partida

- Instancia de GitLab del curso: `https://gitlab.ejemplo.com` (el formador te da la URL real).
- Credenciales: tu usuario (en las páginas, `ana`) y tu contraseña.
- Estado: no hace falta nada más; no se usa la terminal. Si ya tienes un proyecto llamado `manual-equipo`, usa `manual-equipo-web` en el paso 3 y en el resto de rutas.

### En qué consiste

Creas un proyecto en blanco con README, visitas sus secciones principales para saber qué hay en cada una y cambias el README con un commit desde la interfaz web. Clonar y trabajar desde tu equipo queda para el siguiente módulo.

### 1 — Entra en GitLab

**Acción:** abre `https://gitlab.ejemplo.com`, escribe tu usuario y tu contraseña y pulsa **Sign in**.

**Por qué:** el proyecto se crea en tu espacio personal (`ana`), que solo existe con tu sesión iniciada.

**Resultado esperado:** la página de inicio con la barra lateral izquierda y tu avatar.

### 2 — Empieza un proyecto nuevo

**Acción:**
1. En la parte superior de la barra lateral, pulsa **+** y elige **New project/repository**.
2. Pulsa **Create blank project**.

**Por qué:** el manual se empieza desde cero; las otras opciones (plantilla, importar) traen contenido que no es el del equipo.

**Resultado esperado:** el formulario **Create blank project**.

### 3 — Rellena los datos del proyecto

**Acción:**
1. En **Project name**, escribe `manual-equipo`.
2. En **Project URL**, comprueba que el espacio es tu usuario (`ana`) y que **Project slug** es `manual-equipo`.
3. En **Visibility Level**, elige **Private**.
4. En **Project Configuration**, deja marcada **Initialize repository with a README**.

**Por qué:** la URL del proyecto será `https://gitlab.ejemplo.com/ana/manual-equipo`, la que usarás para clonarlo. Privado: solo tú y los miembros que añadas lo veis. El README inicial deja el repositorio con un primer commit y la rama `main`, en lugar de vacío.

**Resultado esperado:** el formulario sin avisos en rojo bajo **Project name** ni **Project slug**.

### 4 — Crea el proyecto

**Acción:** pulsa **Create project**.

**Por qué:** a partir de aquí el repositorio existe en el servidor y tiene historial.

**Resultado esperado:** la página del proyecto `manual-equipo` con un aviso de proyecto creado, la rama `main`, un commit y la lista de archivos con `README.md`. Debajo, el contenido del README renderizado.

### 5 — Code → Repository

**Acción:** en la barra lateral, pulsa **Code** → **Repository**.

**Por qué:** es la vista de los archivos del manual en una rama. Aquí verás `docs/` y las páginas cuando las subas.

**Resultado esperado:** el selector de rama con `main`, la última línea de commit (`Initial commit`, de tu usuario) y la tabla de archivos con `README.md`.

### 6 — Plan → Issues

**Acción:** pulsa **Plan** → **Issues**.

**Por qué:** las tareas del manual («falta la página de vacaciones», «el horario está desactualizado») se registran como issues. Se usan en el M04.

**Resultado esperado:** la lista vacía con un botón **New issue**.

### 7 — Code → Merge requests

**Acción:** pulsa **Code** → **Merge requests**.

**Por qué:** una merge request es la propuesta de integrar los cambios de una rama en `main`, con revisión. Es como entra cada cambio en el manual del equipo.

**Resultado esperado:** la lista vacía, sin merge requests abiertas.

### 8 — Build → Pipelines

**Acción:** pulsa **Build** → **Pipelines**.

**Por qué:** cuando el proyecto tenga un `.gitlab-ci.yml`, cada push lanzará un pipeline que comprueba las páginas del manual. Se ve en el M05.

**Resultado esperado:** una página sin pipelines que invita a configurar CI/CD: el proyecto aún no tiene `.gitlab-ci.yml`.

### 9 — Manage → Members

**Acción:** pulsa **Manage** → **Members**.

**Por qué:** aquí se decide quién más trabaja en el manual y con qué rol. En el M04 añadirás a tu pareja.

**Resultado esperado:** la tabla de miembros con una sola fila: tu usuario, con el rol **Owner**.

### 10 — Settings

**Acción:** pulsa **Settings** → **General** y despliega **Visibility, project features, permissions** con **Expand**. Después, abre **Settings** → **Repository** y despliega **Protected branches**.

**Por qué:** en **General** está la visibilidad que elegiste en el paso 3; en **Repository** → **Protected branches**, las reglas de la rama `main`, que en el M04 se cierran para que solo se integre por merge request.

**Resultado esperado:** **Project visibility** en **Private**, y en **Protected branches** una fila para `main`.

### 11 — Abre el README para editarlo

**Acción:**
1. Vuelve a **Code** → **Repository** y pulsa `README.md`.
2. Pulsa **Edit** y elige **Edit single file**.

**Por qué:** el README que genera GitLab es genérico; el del manual tiene que decir qué es.

**Resultado esperado:** un editor con el contenido actual del README y, debajo, los campos **Commit message** y **Target branch**.

### 12 — Escribe el README del manual

**Acción:** borra todo el contenido y escribe:

```markdown
# Manual del equipo

Todo lo que necesita saber una persona que se incorpora al equipo.
```

**Por qué:** es la cabecera que tendrá el manual completo; el título en la primera línea es lo que el pipeline del M05 exige a cada página.

**Resultado esperado:** el editor solo con esas tres líneas. La pestaña **Preview** muestra el título grande y la frase debajo.

### 13 — Haz el commit desde la web

**Acción:**
1. En **Commit message**, sustituye el texto propuesto por `Describe el manual del equipo`.
2. Deja **Target branch** en `main`.
3. Pulsa **Commit changes**.

**Por qué:** la web no guarda archivos sueltos: cada edición es un commit, con autor y mensaje, igual que `git commit` en la terminal. El mensaje explica el porqué al que lea el historial.

**Resultado esperado:** la página de `README.md` con el contenido nuevo y un aviso de que los cambios se han guardado. Encima del archivo, la línea del último commit: `Describe el manual del equipo`.

### 14 — Code → Commits

**Acción:** pulsa **Code** → **Commits**.

**Por qué:** es el historial del manual: lo que la carpeta compartida no tenía.

**Resultado esperado:** dos commits en `main`, del más reciente al más antiguo: `Describe el manual del equipo` e `Initial commit`, los dos con tu nombre. Al pulsar el primero se ve su diff: en rojo las líneas del README genérico y en verde las tres nuevas.

## Comprueba tu entendimiento

**El historial cuenta lo que hiciste**
Abre **Code** → **Commits** en `manual-equipo`.
→ Dos commits, el último `Describe el manual del equipo`, con tu usuario como autor.

**El proyecto es tuyo y privado**
Abre **Manage** → **Members**.
→ Solo tu usuario, con el rol **Owner**.

**Cada sección, su función**
Sin abrirlas, di dónde mirarías si un compañero propone un cambio en el horario, si alguien avisa de un enlace roto y si quieres saber si las páginas pasan la validación. Después compruébalo en la barra lateral.
→ **Code** → **Merge requests**, **Plan** → **Issues** y **Build** → **Pipelines**.

## Reto

### 1 — Añade la página de bienvenida desde la web

Crea en el proyecto el archivo `docs/bienvenida.md` con la línea `# Bienvenida`, en un commit con el mensaje `Añade la página de bienvenida`, sin usar la terminal.

<details>
<summary>Ver solución</summary>

En **Code** → **Repository**, pulsa **+** (junto al nombre del proyecto) → **New file**. En el nombre del archivo escribe `docs/bienvenida.md` (la barra crea la carpeta `docs/`), en el contenido `# Bienvenida`, en **Commit message** `Añade la página de bienvenida`, con **Target branch** `main`, y pulsa **Commit changes**. En **Code** → **Repository** aparece la carpeta `docs/`, y en **Code** → **Commits**, tres commits.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| Al crear el proyecto, aviso en rojo de que el nombre o la ruta ya están en uso | Ya tienes un proyecto `manual-equipo` en tu espacio | Usa `manual-equipo-web` como nombre, o abre el que ya tienes |
| La página del proyecto dice que el repositorio está vacío y no hay `README.md` | Se desmarcó **Initialize repository with a README** | Añade el archivo desde la web (**+** → **New file**, nombre `README.md`) o borra el proyecto y créalo otra vez |
| Tras **Commit changes** se abre un formulario de merge request y `main` no cambia | Se cambió **Target branch** o se marcó la opción de empezar una merge request con los cambios | Cierra el formulario sin crearla; repite el paso 13 con **Target branch** `main` |
| No aparece **New project/repository** o GitLab no deja crear el proyecto | Tu cuenta no tiene permiso para crear proyectos en la instancia | Pide al formador que revise tu cuenta |
| **Settings** no aparece en la barra lateral | Estás en un proyecto en el que no eres Owner o Maintainer | Comprueba que estás en `ana/manual-equipo` (tu usuario en la ruta) |
