# Lab — Identidad y acceso

[← Página anterior](00-control-de-versiones.md) · [Siguiente página →](02-lab-primer-proyecto.md)

Cada cambio del manual del equipo va a quedar firmado con un nombre y un correo, y esa firma la pone Git con lo que tú le configures. En este lab dejas Git listo para firmar como tú, entras en la instancia de GitLab del curso y creas el token con el que Git se identificará ante GitLab al subir cambios.

### Objetivo

Git configurado con tu nombre, tu correo y la rama `main` por defecto; un commit de prueba que lleva tu identidad, y un token de acceso personal de GitLab guardado para los labs siguientes.

### Punto de partida

- Terminal (Git Bash en Windows) y Git instalado.
- Instancia de GitLab del curso: `https://gitlab.ejemplo.com` (el formador te da la URL real).
- Credenciales: tu usuario de GitLab (en las páginas, `ana`) y su contraseña inicial.
- No hace falta nada de páginas anteriores. Los valores de ejemplo son los de Ana: `Ana` y `ana@equipo.local`; usa los tuyos.

### En qué consiste

Configuras tres valores globales de Git, entras en GitLab, creas un token con los permisos `api` y `write_repository` y compruebas con un repositorio de prueba que los commits salen con tu nombre. No subes nada a GitLab todavía.

### 1 — Comprueba que Git está instalado

**Acción:** `git --version`

**Por qué:** todos los labs dan por hecho Git 2.40 o posterior. Si la terminal no lo encuentra, no tiene sentido seguir.

**Resultado esperado:** una línea con la versión, por ejemplo:

```text
git version 2.53.0
```

### 2 — Configura tu nombre

**Acción:** `git config --global user.name "Ana"`

**Por qué:** es el nombre que aparecerá como autor en cada commit del manual, en tu terminal y en GitLab. `--global` lo guarda para todos tus repositorios.

**Resultado esperado:** el comando no imprime nada. `git config --global user.name` responde `Ana`.

### 3 — Configura tu correo

**Acción:** `git config --global user.email "ana@equipo.local"`

**Por qué:** GitLab asocia cada commit a una cuenta por el correo. Usa el mismo correo que tiene tu cuenta de la instancia del curso: así, en **Code** → **Commits**, el commit aparece enlazado a tu perfil y con tu avatar.

**Resultado esperado:** sin salida. `git config --global user.email` responde `ana@equipo.local`.

### 4 — Usa `main` como rama inicial

**Acción:** `git config --global init.defaultBranch main`

**Por qué:** GitLab llama `main` a la rama principal de los proyectos nuevos. Sin este ajuste, `git init` crea `master` y avisa con un bloque de `hint:`; tu repositorio local y el de GitLab tendrían ramas con nombres distintos.

**Resultado esperado:** sin salida.

### 5 — Revisa la configuración

**Acción:** `git config --global --list`

**Por qué:** de un vistazo confirmas los tres valores y detectas una errata en el correo antes de que quede en el historial.

**Resultado esperado:** al menos estas tres líneas (Git escribe la clave en minúsculas):

```text
user.name=Ana
user.email=ana@equipo.local
init.defaultbranch=main
```

### 6 — Crea un repositorio de prueba

**Acción:**

```bash
mkdir -p ~/trabajo/prueba-identidad
cd ~/trabajo/prueba-identidad
git init
```

**Por qué:** un repositorio desechable para comprobar la identidad sin tocar el manual.

**Resultado esperado:**

```text
Initialized empty Git repository in /home/ana/trabajo/prueba-identidad/.git/
```

Sin ningún `hint:` sobre `master`: el paso 4 ha funcionado.

### 7 — Haz un commit de prueba

**Acción:**

```bash
echo "# Prueba" > prueba.md
git add prueba.md
git commit -m "Comprueba la identidad"
```

**Por qué:** la configuración solo se nota al crear un commit, que es cuando Git escribe el autor.

**Resultado esperado:**

```text
[main (root-commit) 74fda49] Comprueba la identidad
 1 file changed, 1 insertion(+)
 create mode 100644 prueba.md
```

El identificador (`74fda49`) será otro en tu equipo.

### 8 — Comprueba el autor del commit

**Acción:** `git log -1 --format='%an <%ae>'`

**Por qué:** es la firma que verá el equipo en el historial del manual.

**Resultado esperado:**

```text
Ana <ana@equipo.local>
```

### 9 — Entra en la instancia de GitLab

**Acción:**
1. Abre `https://gitlab.ejemplo.com` en el navegador.
2. En **Username or primary email**, escribe `ana`; en **Password**, la contraseña inicial.
3. Pulsa **Sign in**.
4. Si GitLab te pide cambiar la contraseña, escribe la actual y la nueva dos veces y confirma.

**Por qué:** el proyecto del manual vivirá en tu espacio de esta instancia (`ana/…`), y el token se crea desde tu perfil.

**Resultado esperado:** la página de inicio de GitLab con la barra lateral izquierda y tu avatar arriba.

### 10 — Abre la página de tokens

**Acción:**
1. Pulsa tu avatar y elige **Edit profile**.
2. En la barra lateral de **User settings**, pulsa **Access tokens**.
3. Pulsa **Add new token**.

**Por qué:** al subir cambios por HTTPS, Git te pedirá usuario y contraseña. Como contraseña no se usa la de tu cuenta, sino un token: se puede limitar a lo que hace falta y revocar sin cambiar la contraseña.

**Resultado esperado:** un formulario con **Token name**, **Expiration date** y una lista de **scopes** con casillas.

> [!NOTE]
> En las versiones más recientes, GitLab ofrece dos tipos de token: el clásico (*legacy*), con scopes como `api`, y el de permisos finos (*fine-grained*). Si te pregunta cuál, elige el clásico: es el que usa este curso.

### 11 — Crea el token

**Acción:**
1. En **Token name**, escribe `curso-gitlab`.
2. Deja la **Expiration date** que propone GitLab o pon una posterior al final del curso.
3. Marca los scopes `api` y `write_repository`.
4. Pulsa el botón que confirma el formulario: **Generate token** (en versiones anteriores, **Create personal access token**).

**Por qué:** `write_repository` permite a Git clonar y hacer push; `api` permite al script de punto de partida del curso (`scripts/partida.sh`) crear proyectos en tu nombre.

**Resultado esperado:** arriba aparece el aviso **Your new token has been created** con el valor oculto y un botón para copiarlo. Debajo, en la tabla de tokens activos, la fila `curso-gitlab` con los scopes `api, write_repository`.

> [!WARNING]
> GitLab solo enseña el valor del token una vez. Si cierras la página sin copiarlo, no se puede recuperar: revócalo y crea otro.

### 12 — Guarda el token

**Acción:** copia el token con el botón de copiar y guárdalo en tu gestor de contraseñas, con el nombre `GitLab curso — token`.

**Por qué:** lo vas a pegar como contraseña en el primer push y la primera vez que ejecutes `scripts/partida.sh` (que lo guarda en `~/.curso-gitlab`). No lo pegues en un documento compartido ni en un archivo del manual: quien lo tenga puede escribir en tus proyectos.

**Resultado esperado:** el token guardado fuera de GitLab, y la fila `curso-gitlab` visible en **Access tokens**.

## Comprueba tu entendimiento

**La identidad que usará Git**
En cualquier carpeta, ejecuta `git config user.name` y `git config user.email`.
→ `Ana` y `ana@equipo.local` (con tus valores).

**De dónde sale el correo**
Ejecuta `git config --show-origin user.email`.
→ Una línea con la ruta de tu `.gitconfig` global (en Linux, `file:/home/ana/.gitconfig`) y el correo.

**El token existe**
En GitLab, abre tu avatar → **Edit profile** → **Access tokens**.
→ La fila `curso-gitlab` con los scopes `api` y `write_repository`, sin el valor del token.

## Reto

### 1 — Otra identidad solo para un repositorio

En `~/trabajo/prueba-identidad`, haz que los commits salgan con el correo `ana.manual@equipo.local` sin cambiar tu configuración global. Haz un commit y comprueba qué autor lleva.

<details>
<summary>Ver solución</summary>

Sin `--global`, el valor se guarda en `.git/config` de ese repositorio y tiene prioridad sobre el global:

```bash
cd ~/trabajo/prueba-identidad
git config user.email "ana.manual@equipo.local"
git config --show-origin --get-all user.email
```

```text
file:/home/ana/.gitconfig	ana@equipo.local
file:.git/config	ana.manual@equipo.local
```

Tras un commit, `git log -1 --format='%an <%ae>'` muestra `Ana <ana.manual@equipo.local>`. En cualquier otro repositorio sigue valiendo `ana@equipo.local`.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| `git commit` falla con `Author identity unknown` / `*** Please tell me who you are.` y `fatal: unable to auto-detect email address (got 'ana@portatil.(none)')` | Falta `user.name` o `user.email` | Repite los pasos 2 y 3 y vuelve a lanzar el `git commit` |
| `git: command not found` (o `'git' is not recognized…` en Windows) | Git no está instalado o la terminal no lo encuentra | Instala Git (en Windows, Git for Windows) y abre una terminal nueva; en Windows usa Git Bash |
| `git init` muestra `hint: Using 'master' as the name for the initial branch.` y `git status` dice `On branch master` | Falta `init.defaultBranch` | Haz el paso 4; en el repositorio ya creado, `git branch -m main` |
| Los commits aparecen en GitLab sin tu avatar ni enlace a tu perfil | El `user.email` de Git no coincide con el correo de tu cuenta de GitLab | Cambia `user.email` al correo de tu cuenta; afecta a los commits nuevos |
| No encuentras el valor del token | GitLab solo lo muestra al crearlo | En **Access tokens**, revoca `curso-gitlab` y crea uno nuevo (pasos 10 y 11) |
| Un comando que usa el token responde `401` o pide la contraseña una y otra vez | Token caducado, revocado o sin el scope `write_repository` | Crea un token nuevo con `api` y `write_repository` |
