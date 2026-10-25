# El ciclo de un cambio

[← Página anterior](README.md) · [Siguiente página →](01-lab-clonar.md)

El equipo ha decidido adelantar la reunión de los lunes y hay que reflejarlo en el manual. Esta demostración sigue ese cambio de principio a fin: el proyecto `manual-equipo` se trae de GitLab al equipo, la página se edita en VS Code, el cambio se registra en un commit y se publica, y al final aparece en GitLab con su autor y sus líneas cambiadas. Es el recorrido que se repite en cada cambio del manual.

## Punto de partida

- Proyecto en GitLab: `https://gitlab.ejemplo.com/ana/manual-m02-demo`, creado desde la carpeta del repo del curso con:

  ```bash
  scripts/partida.sh manual-m02-demo --solo-remoto
  ```

  Tiene el manual completo y tres commits de historial. Con `--solo-remoto` no se clona: el clonado forma parte del recorrido.
- Identidad: usuaria `ana`, con Git configurado como `ana` / `ana@equipo.local` y un token de acceso personal con los scopes `api` y `write_repository` (se crean en [Lab — Identidad y acceso](../M01-introduccion-git-gitlab/01-lab-identidad-y-acceso.md)).
- Equipo: Git, VS Code y una terminal (Git Bash en Windows). Las copias de trabajo van en `~/trabajo/`.

## Recorrido

1. **La URL de clonado.** En la página del proyecto, el botón **Code** despliega las direcciones del repositorio. En **Clone with HTTPS** está la que se usa en el curso: `https://gitlab.ejemplo.com/ana/manual-m02-demo.git`.

2. **El clonado.** En la terminal, desde `~/trabajo`:

   ```console
   $ git clone https://gitlab.ejemplo.com/ana/manual-m02-demo.git
   Cloning into 'manual-m02-demo'...
   ```

   Como el proyecto es privado, Git pide usuario (`ana`) y contraseña (el token). Al acabar existe `~/trabajo/manual-m02-demo` con `README.md`, `docs/` y `scripts/`, y el historial completo: los tres commits del proyecto están ya en el equipo.

3. **La edición en VS Code.** Con `code .` dentro de la carpeta se abre el proyecto. En `docs/normas-de-trabajo.md`, bajo `## Reuniones`, la línea `- Reunión de equipo: lunes a las 10:00.` pasa a `- Reunión de equipo: lunes a las 9:30.` y se guarda el archivo. VS Code marca el archivo con una `M` en el explorador y en la vista **Source Control**.

4. **El estado.** `git status` confirma lo que ve VS Code: el archivo está modificado, pero aún no preparado para el commit.

   ```console
   $ git status
   On branch main
   Your branch is up to date with 'origin/main'.

   Changes not staged for commit:
     (use "git add <file>..." to update what will be committed)
     (use "git restore <file>..." to discard changes in working directory)
   	modified:   docs/normas-de-trabajo.md

   no changes added to commit (use "git add" and/or "git commit -a")
   ```

   `git diff` muestra exactamente qué ha cambiado: una línea fuera (`-`) y otra dentro (`+`).

   ```diff
   @@ -6,7 +6,7 @@ El horario de referencia es de 9:00 a 17:00, con flexibilidad de una hora a la e

    ## Reuniones

   -- Reunión de equipo: lunes a las 10:00.
   +- Reunión de equipo: lunes a las 9:30.
    - Las reuniones tienen orden del día y acaban con acuerdos escritos.
   ```

5. **La preparación.** `git add docs/normas-de-trabajo.md` pasa el cambio al área de preparación. El archivo cambia de bloque en `git status`:

   ```console
   $ git status
   On branch main
   Your branch is up to date with 'origin/main'.

   Changes to be committed:
     (use "git restore --staged <file>..." to unstage)
   	modified:   docs/normas-de-trabajo.md
   ```

6. **El commit.** El mensaje dice qué cambia en el manual, no qué archivo se tocó:

   ```console
   $ git commit -m "Adelanta la reunión de equipo a las 9:30"
   [main 90b49e9] Adelanta la reunión de equipo a las 9:30
    1 file changed, 1 insertion(+), 1 deletion(-)
   ```

   En este momento el commit solo existe en el equipo de `ana`. En GitLab todavía no hay nada nuevo.

7. **La publicación.** `git push` sube el commit a GitLab:

   ```console
   $ git push
   ...
   To https://gitlab.ejemplo.com/ana/manual-m02-demo.git
      6805161..90b49e9  main -> main
   ```

   Antes salen unas líneas de progreso (`Enumerating objects`, `Writing objects`…). La última línea dice que la rama `main` de GitLab ha pasado del commit `6805161` al `90b49e9`. Después, `git status` vuelve a `Your branch is up to date with 'origin/main'.` y `git log --oneline` muestra el commit nuevo encima de los tres de partida:

   ```console
   $ git log --oneline
   90b49e9 Adelanta la reunión de equipo a las 9:30
   6805161 Añade normas de trabajo y scripts de validación
   3ba8129 Añade bienvenida y herramientas
   e51f242 Crea el manual del equipo
   ```

8. **El commit en GitLab.** En la barra lateral, **Code** → **Commits** lista los commits de `main`. El primero es «Adelanta la reunión de equipo a las 9:30», de `ana`, con el mismo identificador corto. Al abrirlo aparece el diff de `docs/normas-de-trabajo.md` con la línea de las 10:00 en rojo y la de las 9:30 en verde. En **Code** → **Repository**, la página `docs/normas-de-trabajo.md` ya dice 9:30.

> [!NOTE]
> Los identificadores de commit (`90b49e9`…) son distintos en cada proyecto: dependen del contenido, el autor y la fecha.

## Qué queda visto

El ciclo completo de un cambio: `clone` una vez, y en cada cambio editar, `status`, `add`, `commit` y `push`, con el resultado comprobado en GitLab. Cada tramo se practica en su laboratorio, y todos se pueden hacer sin haber seguido esta demostración:

- [Lab — Clonar](01-lab-clonar.md): clonado y estados de los archivos.
- [Lab — Commits](02-lab-commits.md): `add` y `commit` de cambios separados.
- [Lab — Publicar y comparar](03-lab-publicar-y-comparar.md): `diff`, `log`, `push`, `fetch` y `pull`.
- [Lab — .gitignore](04-lab-gitignore.md): archivos que no deben entrar en el repositorio.
