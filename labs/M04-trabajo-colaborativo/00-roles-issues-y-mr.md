# Roles, issues y merge requests

[← Página anterior](README.md) · [Siguiente página →](01-lab-proyecto-compartido.md)

Una persona recién incorporada avisa de que la bienvenida del proyecto no dice dónde se pide el portátil. En un equipo, ese aviso no se arregla con un push a `main`: se registra como issue, se resuelve en una rama, se propone en una merge request y lo revisa otra persona antes de fusionarlo. Esta demostración recorre ese camino completo en el proyecto de Ana, con Luis como revisor. Las dos personas las maneja quien sigue la demostración: Ana en su ordenador y en una ventana normal del navegador, Luis en una ventana privada.

## Punto de partida

- El entorno de prácticas levantado ([El entorno de prácticas](../../infra/README.md)).
- Identidades: `ana` (dueña del proyecto, rol Owner) y `luis` (miembro con rol Developer).
- Estado: proyecto `ana/manual-m04-demo`, creado con

  ```bash
  # 🖥️ Terminal del Codespace
  scripts/partida.sh ana manual-m04-demo --miembro luis
  ```

  que lo clona en `~/trabajo/manual-m04-demo` de los ordenadores de Ana y de Luis y añade a `luis` como Developer. Además, `main` está protegida (**Allowed to push and merge**: **No one**). Cómo se hacen esas dos cosas está en el [Lab — Proyecto compartido](01-lab-proyecto-compartido.md).
- La página afectada es `docs/bienvenida.md`, que en el apartado «Primer día» dice:

```markdown
- Recoge tu portátil en el puesto de soporte.
```

## Recorrido

1. **La issue** (🌐 GitLab, sesión de Ana). En **Plan → Issues → New issue**, Ana registra la issue con el título «La bienvenida no dice dónde pedir el portátil» y una descripción breve: «Quien se incorpora no sabe a quién pedir el portátil antes de llegar; solo pone dónde recogerlo». En **Assignee** se asigna a sí misma. Al pulsar **Create issue**, GitLab le da el número **#1**. A partir de aquí, cualquiera que escriba `#1` en un comentario, un commit o una MR la enlaza.

   > 📷 **Captura pendiente** · `M04-00-issue.png` — GitLab, sesión de Ana: la issue #1 recién creada.

2. **La rama, con el número de la issue** (💻 Ordenador de Ana). Desde la propia issue, el botón **Create merge request** (o su desplegable, con la opción **Create branch**) crea una rama cuyo nombre empieza por `1-` y una MR en borrador ligada a la issue. En esta demostración la rama se crea en el ordenador de Ana, con el mismo convenio de nombre:

```console
# 💻 Ordenador de Ana
$ git switch -c 1-bienvenida-portatil
Switched to a new branch '1-bienvenida-portatil'
```

   El prefijo `1-` no es decorativo: dice qué issue resuelve la rama y GitLab lo usa para relacionarlas.

3. **El cambio y el commit** (📝 VS Code y 💻 ordenador de Ana). En `home-ana/trabajo/manual-m04-demo/docs/bienvenida.md`, la línea del portátil queda así, y `git diff` lo muestra:

```diff
-- Recoge tu portátil en el puesto de soporte.
+- Pide tu portátil a soporte@equipo.local antes de tu primer día y recógelo en el puesto de soporte.
```

```console
# 💻 Ordenador de Ana
$ git commit -am "Indica dónde pedir el portátil (#1)"
[1-bienvenida-portatil e5dfd09] Indica dónde pedir el portátil (#1)
 1 file changed, 1 insertion(+), 1 deletion(-)
```

4. **El push** (💻 Ordenador de Ana). `git push -u origin 1-bienvenida-portatil` publica la rama. Como `main` está protegida, esta es la única forma de llevar el cambio a GitLab. En la respuesta, GitLab sugiere el enlace para abrir la merge request:

```console
remote:
remote: To create a merge request for 1-bienvenida-portatil, visit:
remote:   http://localhost:8080/ana/manual-m04-demo/-/merge_requests/new?merge_request%5Bsource_branch%5D=1-bienvenida-portatil
remote:
To gitlab:ana/manual-m04-demo.git
 * [new branch]      1-bienvenida-portatil -> 1-bienvenida-portatil
branch '1-bienvenida-portatil' set up to track 'origin/1-bienvenida-portatil'.
```

5. **La merge request** (🌐 GitLab, sesión de Ana). El enlace abre el formulario de **New merge request** con la rama de origen `1-bienvenida-portatil` y la de destino `main`. La descripción lleva la línea:

```markdown
Closes #1
```

   En **Reviewer** aparece `luis`. Al pulsar **Create merge request**, la MR queda como **!1** (las MR usan `!` y las issues `#`). En la issue #1 aparece ahora la MR relacionada: issue, rama y MR quedan enlazadas.

   > 📷 **Captura pendiente** · `M04-00-mr.png` — GitLab, sesión de Ana: la MR !1 con `Closes #1` y `luis` como revisor.

6. **La revisión con sugerencia** (🌐 GitLab, sesión de Luis, en la ventana privada). Luis abre la MR, entra en la pestaña **Changes** y ve el diff de `docs/bienvenida.md`. Le parece bien, pero prefiere que el correo esté en la tabla «A quién preguntar» y que la línea sea más corta. Pasa el ratón por la línea nueva, pulsa el icono de comentario y escribe una **sugerencia de cambio**: un bloque `suggestion` con el texto que propone para esa línea.

````markdown
Más corto, y el correo ya está en «A quién preguntar»:

```suggestion
- Pide tu portátil a soporte antes de tu primer día y recógelo en su puesto.
```
````

   En la MR, la sugerencia no se ve como texto suelto, sino como un mini-diff con la línea actual y la propuesta.

   > 📷 **Captura pendiente** · `M04-00-sugerencia.png` — GitLab, sesión de Luis: la sugerencia en la pestaña **Changes**.

7. **Aplicar la sugerencia** (🌐 GitLab, sesión de Ana). Ana, autora de la MR, ve el comentario con el botón **Apply suggestion**. Al aplicarla, GitLab crea un commit nuevo en la rama `1-bienvenida-portatil` con el cambio propuesto, sin que ella tenga que editar el fichero ni hacer push. El hilo del comentario queda resuelto.

8. **La fusión** (🌐 GitLab, sesión de Ana). Con la revisión terminada, quien tiene permiso de fusión en `main` (en este proyecto, los Maintainers: `ana`) pulsa **Merge** en la pestaña **Overview**. La casilla **Delete source branch** está marcada, así que la rama `1-bienvenida-portatil` desaparece al fusionar. La MR pasa a **Merged**.

9. **La issue cerrada.** Gracias a `Closes #1`, la issue #1 aparece como **Closed**, y en su actividad se lee que la cerró la merge request !1. En **Code → Repository**, `docs/bienvenida.md` ya muestra la línea sugerida por Luis.

## Qué queda visto

El recorrido completo de un cambio en equipo: una issue con número, una rama que empieza por ese número, una MR que dice qué issue cierra, una revisión con una sugerencia aplicada desde la web y una fusión que borra la rama y cierra la issue. Nadie ha escrito directamente en `main`.

Los tres laboratorios lo practican por partes, haciendo tú de Ana y de Luis, y cada uno desde su propio punto de partida: [01 — Proyecto compartido](01-lab-proyecto-compartido.md) (miembros y rama protegida), [02 — De la issue a la merge request](02-lab-de-issue-a-mr.md) y [03 — Revisión](03-lab-revision.md).
