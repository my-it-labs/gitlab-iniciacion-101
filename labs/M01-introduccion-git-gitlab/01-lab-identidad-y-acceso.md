# Lab — Identidad y acceso

[← Página anterior](00-control-de-versiones.md) · [Siguiente página →](02-lab-primer-proyecto.md)

El equipo del proyecto son dos personas, Ana y Luis, cada una con su ordenador. Cada cambio que hagan va a quedar firmado con un nombre y un correo, y esa firma la pone Git con lo que cada uno configure en su ordenador. Además, para subir cambios a GitLab, el ordenador de cada persona tiene que demostrar quién es: lo hace con una clave SSH. En este lab te sientas primero en el ordenador de Ana y después en el de Luis, y dejas a los dos listos para trabajar.

### Objetivo

En el ordenador de Ana y en el de Luis: Git configurado con su nombre, su correo y la rama `main` por defecto, un commit de prueba con su firma y una clave SSH registrada en su perfil de GitLab, comprobada con `ssh -T git@gitlab`.

### Punto de partida

- El entorno de prácticas levantado con `infra/bootstrap.sh`. Qué es cada pieza y cómo se entra en cada ordenador: [El entorno de prácticas](../../infra/README.md).
- GitLab en `http://localhost:8080`, con las cuentas `ana` y `luis` y la contraseña `Formacion-2026!`.
- No hace falta nada de páginas anteriores. Si ya hiciste este lab, los pasos de configuración se pueden repetir sin problema; en los de la clave, `ssh-keygen` te preguntará si quieres sobrescribirla: responde `n` y sigue con la que ya tienes.

### En qué consiste

En el ordenador de Ana configuras tres valores de Git, haces un commit de prueba para ver la firma y generas su par de claves SSH. Después, en GitLab con la sesión de Ana, registras la clave pública y, de vuelta en su ordenador, compruebas que GitLab la reconoce. Al final repites lo esencial en el ordenador de Luis.

## Ana

### 1 — Entra en el ordenador de Ana

**Acción:**

```bash
# 🖥️ Terminal del Codespace
docker exec -it pc-ana bash
```

**Por qué:** a partir de aquí todo lo que escribas lo hace Ana en su ordenador, `pc-ana`. Su configuración de Git y su clave SSH se guardan en su carpeta personal, `/home/ana`, y no las comparte con nadie.

**Resultado esperado:** el prompt cambia y dice quién eres y en qué ordenador estás:

```text
ana@pc-ana:~$
```

### 2 — Comprueba que Git está instalado

**Acción:**

```bash
# 💻 Ordenador de Ana
git --version
```

**Por qué:** todos los labs dan por hecho Git 2.40 o posterior.

**Resultado esperado:** una línea con la versión:

```text
[salida pendiente: se captura al validar]
```

### 3 — Configura el nombre de Ana

**Acción:**

```bash
# 💻 Ordenador de Ana
git config --global user.name "Ana"
```

**Por qué:** es el nombre que aparecerá como autor en cada commit de Ana, en su terminal y en GitLab. `--global` lo guarda para todos los repositorios de este ordenador.

**Resultado esperado:** el comando no imprime nada. `git config --global user.name` responde `Ana`.

### 4 — Configura el correo de Ana

**Acción:**

```bash
# 💻 Ordenador de Ana
git config --global user.email "ana@equipo.local"
```

**Por qué:** GitLab asocia cada commit a una cuenta por el correo. `ana@equipo.local` es el de la cuenta `ana` en GitLab: así, en **Code** → **Commits**, los commits de Ana aparecen enlazados a su perfil y con su avatar.

**Resultado esperado:** sin salida. `git config --global user.email` responde `ana@equipo.local`.

### 5 — Usa `main` como rama inicial

**Acción:**

```bash
# 💻 Ordenador de Ana
git config --global init.defaultBranch main
```

**Por qué:** GitLab llama `main` a la rama principal de los proyectos nuevos. Sin este ajuste, `git init` crea `master` y avisa con un bloque de `hint:`; el repositorio de Ana y el de GitLab tendrían ramas con nombres distintos.

**Resultado esperado:** sin salida.

### 6 — Revisa la configuración

**Acción:**

```bash
# 💻 Ordenador de Ana
git config --global --list
```

**Por qué:** de un vistazo confirmas los tres valores y detectas una errata en el correo antes de que quede en el historial.

**Resultado esperado:** estas tres líneas (Git escribe la clave en minúsculas):

```text
user.name=Ana
user.email=ana@equipo.local
init.defaultbranch=main
```

### 7 — Haz un commit de prueba

**Acción** (📝 VS Code, ordenador de Ana): en el explorador de VS Code, despliega `home-ana/`: es la carpeta personal de Ana. Crea dentro la carpeta `trabajo/prueba-identidad/` y, en ella, el archivo `prueba.md` con una sola línea, `# Prueba`. Guarda.

**Acción** (💻 Ordenador de Ana): convierte la carpeta en repositorio y haz el commit:

```bash
# 💻 Ordenador de Ana
cd ~/trabajo/prueba-identidad
git init
git add prueba.md
git commit -m "Comprueba la identidad"
```

**Por qué:** lo que creas en `home-ana/` con VS Code está en el ordenador de Ana: es la misma carpeta que su `~`. La configuración solo se nota al crear un commit, que es cuando Git escribe el autor. El repositorio es desechable: no toca el proyecto.

**Resultado esperado:** `git init` sin ningún `hint:` sobre `master` (el paso 5 ha funcionado) y el commit en `main`:

```text
Initialized empty Git repository in /home/ana/trabajo/prueba-identidad/.git/
[main (root-commit) 74fda49] Comprueba la identidad
 1 file changed, 1 insertion(+)
 create mode 100644 prueba.md
```

El identificador (`74fda49`) será otro en tu entorno.

### 8 — Comprueba la firma del commit

**Acción:**

```bash
# 💻 Ordenador de Ana
git log -1 --format='%an <%ae>'
```

**Por qué:** es la firma que verá el equipo en el historial del proyecto.

**Resultado esperado:**

```text
Ana <ana@equipo.local>
```

### 9 — Genera la clave SSH de Ana

**Acción:**

```bash
# 💻 Ordenador de Ana
ssh-keygen -t ed25519 -C "ana@pc-ana"
```

Pulsa **Enter** en las tres preguntas: ubicación por defecto y sin frase de paso.

**Por qué:** una clave SSH son dos archivos. La **privada** (`~/.ssh/id_ed25519`) no sale nunca del ordenador de Ana; la **pública** (`~/.ssh/id_ed25519.pub`) se entrega a GitLab. Cuando Ana haga `git push`, su ordenador demuestra con la privada que es el dueño de la pública que GitLab tiene registrada, sin enviar ninguna contraseña. El comentario `ana@pc-ana` sirve para reconocer en GitLab de qué ordenador es la clave.

**Resultado esperado:** el aviso de que se han guardado los dos archivos y la huella de la clave:

```text
[salida pendiente: se captura al validar]
```

> [!NOTE]
> En tu trabajo real, ponle una frase de paso a la clave: si alguien copia el archivo privado, sin la frase no le sirve. Aquí se deja vacía para que los labs no la pidan en cada push.

### 10 — Copia la clave pública

**Acción** (📝 VS Code, ordenador de Ana): en el explorador, abre `home-ana/.ssh/id_ed25519.pub` (la que acaba en `.pub`), selecciona la línea completa y cópiala.

**Por qué:** es lo que vas a pegar en GitLab. Es pública: enseñarla no es un riesgo. Al lado está `id_ed25519`, sin `.pub`: es la privada, y no se abre ni se copia nunca.

**Resultado esperado:** una sola línea que empieza por `ssh-ed25519` y termina en `ana@pc-ana`.

> 📷 **Captura pendiente** · `M01-01-clave-publica-vscode.png` — VS Code: `home-ana/.ssh/` con los dos archivos y `id_ed25519.pub` abierto.

### 11 — Entra en GitLab como Ana

**Acción** (🌐 GitLab, sesión de Ana):
1. Abre `http://localhost:8080` en una ventana normal del navegador.
2. En **Username or primary email**, escribe `ana`; en **Password**, `Formacion-2026!`.
3. Pulsa **Sign in**.
4. Si GitLab te pide cambiar la contraseña, escribe la actual y la nueva dos veces y confirma.

**Por qué:** la clave se registra en el perfil de la persona. GitLab sabrá que todo lo que llegue firmado con ella viene de Ana.

**Resultado esperado:** la página de inicio de GitLab con la barra lateral izquierda y el avatar de Ana arriba.

> 📷 **Captura pendiente** · `M01-01-inicio-ana.png` — GitLab, sesión de Ana: página de inicio con el avatar.

### 12 — Registra la clave de Ana

**Acción** (🌐 GitLab, sesión de Ana):
1. Pulsa el avatar y elige **Edit profile**.
2. En la barra lateral de **User settings**, pulsa **SSH Keys**.
3. Pulsa **Add new key**.
4. En **Key**, pega la línea que copiaste en el paso 10 desde `home-ana/.ssh/id_ed25519.pub`.
5. **Title** se rellena solo con `ana@pc-ana`; déjalo así.
6. Deja **Usage type** y **Expiration date** como estén y pulsa **Add key**.

**Por qué:** desde ahora, GitLab acepta las conexiones SSH que vengan del ordenador de Ana como si fueran Ana. Si mañana Ana cambia de ordenador, se registra la clave del nuevo y se borra la del viejo, sin tocar la contraseña.

**Resultado esperado:** la página de la clave con su título `ana@pc-ana` y su huella (*fingerprint*). En **SSH Keys** aparece una fila con ese título.

> 📷 **Captura pendiente** · `M01-01-ssh-key-ana.png` — GitLab, sesión de Ana: **SSH Keys** con la clave `ana@pc-ana`.

### 13 — Comprueba que GitLab reconoce a Ana

**Acción:**

```bash
# 💻 Ordenador de Ana
ssh -T git@gitlab
```

La primera vez, SSH pregunta si confías en el servidor `gitlab`: escribe `yes` y pulsa **Enter**.

**Por qué:** `-T` abre una conexión SSH con GitLab sin pedir una terminal: GitLab solo contesta quién cree que eres. La pregunta del principio sale una sola vez por servidor; la respuesta queda en `~/.ssh/known_hosts` y protege a Ana de conectarse sin saberlo a otro servidor que se haga pasar por GitLab.

**Resultado esperado:** la pregunta de confianza la primera vez y, al final, el saludo con el usuario de Ana:

```text
[salida pendiente: se captura al validar]
```

La última línea tiene que ser `Welcome to GitLab, @ana!`.

### 14 — Sal del ordenador de Ana

**Acción:**

```bash
# 💻 Ordenador de Ana
exit
```

**Por qué:** vuelves al terminal del Codespace para sentarte en el ordenador de Luis. Lo configurado se queda guardado en el de Ana.

**Resultado esperado:** el prompt vuelve a ser el del Codespace y ya no dice `ana@pc-ana`.

## Luis

Luis hace lo mismo en su ordenador. Los pasos son los de Ana con sus datos; el porqué de cada uno está arriba.

### 15 — Entra en el ordenador de Luis y configura Git

**Acción:**

```bash
# 🖥️ Terminal del Codespace
docker exec -it pc-luis bash
```

```bash
# 💻 Ordenador de Luis
git config --global user.name "Luis"
git config --global user.email "luis@equipo.local"
git config --global init.defaultBranch main
git config --global --list
```

**Por qué:** cada ordenador tiene su propia configuración. Lo que configuraste en el de Ana no existe en el de Luis: si Luis hiciera un commit sin este paso, Git no sabría quién es.

**Resultado esperado:** el prompt `luis@pc-luis:~$` y, tras el último comando:

```text
user.name=Luis
user.email=luis@equipo.local
init.defaultbranch=main
```

### 16 — Genera la clave SSH de Luis

**Acción:**

```bash
# 💻 Ordenador de Luis
ssh-keygen -t ed25519 -C "luis@pc-luis"
```

Pulsa **Enter** en las tres preguntas. Después, en VS Code (📝), abre `home-luis/.ssh/id_ed25519.pub` y copia su línea.

**Por qué:** la clave de Luis es suya y distinta de la de Ana. Así GitLab distingue quién sube cada cambio aunque los dos trabajen en el mismo proyecto.

**Resultado esperado:** `ssh-keygen` informa de los dos archivos creados, y `id_ed25519.pub` tiene una línea que empieza por `ssh-ed25519` y termina en `luis@pc-luis`. Fíjate en la carpeta: `home-luis/`, no `home-ana/`.

### 17 — Registra la clave de Luis

**Acción** (🌐 GitLab, sesión de Luis):
1. Abre una **ventana privada** del navegador y entra en `http://localhost:8080` con `luis` y `Formacion-2026!`.
2. Avatar → **Edit profile** → **SSH Keys** → **Add new key**.
3. Pega la clave en **Key**, deja **Title** en `luis@pc-luis` y pulsa **Add key**.

**Por qué:** la ventana privada tiene su propia sesión, así que Ana sigue conectada en la ventana normal. Comprueba el avatar antes de pulsar **Add key**: si registras la clave de Luis en el perfil de Ana, GitLab creerá que los cambios de Luis son de Ana.

**Resultado esperado:** en **SSH Keys** de Luis, una fila con el título `luis@pc-luis`.

> 📷 **Captura pendiente** · `M01-01-ssh-key-luis.png` — GitLab, sesión de Luis (ventana privada): **SSH Keys** con la clave `luis@pc-luis`.

### 18 — Comprueba que GitLab reconoce a Luis

**Acción:**

```bash
# 💻 Ordenador de Luis
ssh -T git@gitlab
```

Responde `yes` a la pregunta de confianza.

**Por qué:** es la misma comprobación que hiciste con Ana; ahora GitLab tiene que responder con el otro usuario.

**Resultado esperado:**

```text
[salida pendiente: se captura al validar]
```

La última línea tiene que ser `Welcome to GitLab, @luis!`.

## Comprueba tu entendimiento

**Cada ordenador, su firma**
En el ordenador de Ana y en el de Luis, ejecuta `git config user.email`.
→ `ana@equipo.local` en `pc-ana` y `luis@equipo.local` en `pc-luis`.

**De dónde sale la configuración**
En el ordenador de Ana, ejecuta `git config --show-origin user.email`.
→ Una línea con `file:/home/ana/.gitconfig` y el correo: la configuración global es un archivo en la carpeta personal de Ana. En VS Code es `home-ana/.gitconfig`: ábrelo y verás los tres valores.

**Cada clave, su persona**
En los dos ordenadores, ejecuta `ssh -T git@gitlab`.
→ `Welcome to GitLab, @ana!` en `pc-ana` y `Welcome to GitLab, @luis!` en `pc-luis`.

## Reto

### 1 — Otra identidad solo para un repositorio

En el ordenador de Ana, haz que los commits de `~/trabajo/prueba-identidad` salgan con el correo `ana.manual@equipo.local` sin cambiar su configuración global. Haz un commit y comprueba qué autor lleva.

<details>
<summary>Ver solución</summary>

Sin `--global`, el valor se guarda en `.git/config` de ese repositorio y tiene prioridad sobre el global:

```bash
# 💻 Ordenador de Ana
cd ~/trabajo/prueba-identidad
git config user.email "ana.manual@equipo.local"
git config --show-origin --get-all user.email
```

```text
file:/home/ana/.gitconfig	ana@equipo.local
file:.git/config	ana.manual@equipo.local
```

Tras un commit, `git log -1 --format='%an <%ae>'` muestra `Ana <ana.manual@equipo.local>`. En cualquier otro repositorio de Ana sigue valiendo `ana@equipo.local`.

</details>

### 2 — ¿Qué pasa si la clave está en el perfil equivocado?

Sin hacerlo, razona: si en el paso 17 hubieras pegado la clave de Luis en el perfil de Ana, ¿qué respondería `ssh -T git@gitlab` en el ordenador de Luis?

<details>
<summary>Ver solución</summary>

`Welcome to GitLab, @ana!`. GitLab identifica a quien se conecta solo por la clave: el ordenador de Luis entraría como Ana, y todo lo que Luis subiera llegaría a GitLab con los permisos de Ana. Por eso cada persona registra su clave en su propio perfil y comprueba el saludo.

</details>

## Errores frecuentes

| Síntoma | Causa probable | Cómo arreglarlo |
|---------|----------------|-----------------|
| `Error response from daemon: No such container: pc-ana` | El entorno no está levantado | En el terminal del Codespace, ejecuta `infra/bootstrap.sh` |
| El prompt no dice `ana@pc-ana` o `luis@pc-luis` | Estás en el terminal del Codespace o en el otro ordenador | Mira el prompt; entra con `docker exec -it pc-ana bash` (o `pc-luis`) |
| `git commit` falla con `Author identity unknown` / `*** Please tell me who you are.` | Falta `user.name` o `user.email` en ese ordenador | Repite los pasos 3 y 4 (o el 15 para Luis) en el ordenador donde estés |
| `git init` muestra `hint: Using 'master' as the name for the initial branch.` | Falta `init.defaultBranch` | Haz el paso 5; en el repositorio ya creado, `git branch -m main` |
| `ssh -T git@gitlab` responde `git@gitlab: Permission denied (publickey).` | La clave no está registrada en GitLab, o se pegó incompleta | Repite el paso 12 (o el 17) pegando la línea entera de `home-ana/.ssh/id_ed25519.pub` (o `home-luis/…`) |
| `ssh -T git@gitlab` saluda al otro usuario | La clave se registró en el perfil equivocado | En el perfil que no toca, **SSH Keys** → borra la clave; regístrala en el correcto |
| GitLab rechaza la clave con `Fingerprint sha256 has already been taken` | Esa clave ya está registrada, quizá en el otro perfil | Busca en **SSH Keys** de las dos cuentas y borra la que sobra |
| Los commits aparecen en GitLab sin avatar ni enlace al perfil | El `user.email` de Git no coincide con el correo de la cuenta | Cambia `user.email` al correo de la cuenta; afecta a los commits nuevos |
