# Ramas como punteros

[← Página anterior](README.md) · [Siguiente página →](01-lab-rama-y-merge.md)

El equipo quiere una página de preguntas frecuentes en el proyecto. Mientras se escribe, `main` debe seguir mostrando el proyecto tal como está. En esta demostración, Ana escribe la página en una rama, `nueva-pagina-faq`, con dos commits, y la fusiona después. El grafo de Git y el de GitLab enseñan qué es realmente una rama: un nombre que apunta a un commit y que avanza con cada commit nuevo.

## Punto de partida

- El entorno de prácticas levantado ([El entorno de prácticas](../../infra/README.md)).
- Proyecto `ana/manual-m03-demo`, creado y clonado en el ordenador de Ana con:

  ```bash
  # 🖥️ Terminal del Codespace
  scripts/partida.sh ana manual-m03-demo
  ```

  Tiene tres commits en `main` («Crea el manual del equipo», «Añade bienvenida y herramientas», «Añade normas de trabajo y scripts de validación»).
- Todo lo que sigue en la terminal ocurre en el ordenador de Ana (`docker exec -it pc-ana bash`), en `~/trabajo/manual-m03-demo`. El script deja allí su identidad de Git y su clave SSH.

## Recorrido

### 1. Antes de crear la rama

`git log --oneline --graph --all` dibuja todos los commits y, entre paréntesis, los nombres que apuntan a cada uno:

```text
* dfed5ec (HEAD -> main, origin/main, origin/HEAD) Añade normas de trabajo y scripts de validación
* 04de6d9 Añade bienvenida y herramientas
* 226d69b Crea el manual del equipo
```

Hay una sola línea de historia. `main` apunta al último commit, `HEAD -> main` indica que Ana está en `main` y `origin/main` es lo último que Git sabe de la rama `main` de GitLab.

### 2. Se crea la rama

```bash
# 💻 Ordenador de Ana
git switch -c nueva-pagina-faq
```

```text
Switched to a new branch 'nueva-pagina-faq'
```

```text
* dfed5ec (HEAD -> nueva-pagina-faq, origin/main, origin/HEAD, main) Añade normas de trabajo y scripts de validación
* 04de6d9 Añade bienvenida y herramientas
* 226d69b Crea el manual del equipo
```

No se ha copiado ningún archivo ni ha aparecido ningún commit. Solo hay un nombre más, `nueva-pagina-faq`, sobre el mismo commit que `main`, y `HEAD` ahora señala a la rama nueva. Crear una rama es instantáneo por eso: es una etiqueta.

### 3. Dos commits en la rama

En VS Code, Ana crea `home-ana/trabajo/manual-m03-demo/docs/preguntas-frecuentes.md` y la confirma («Añade la página de preguntas frecuentes»). Después añade al índice de su `README.md` la línea `- [Preguntas frecuentes](docs/preguntas-frecuentes.md)` y la confirma («Enlaza las preguntas frecuentes desde el índice»). El grafo queda así:

```text
* 8ebdb6f (HEAD -> nueva-pagina-faq) Enlaza las preguntas frecuentes desde el índice
* 767c3c1 Añade la página de preguntas frecuentes
* dfed5ec (origin/main, origin/HEAD, main) Añade normas de trabajo y scripts de validación
* 04de6d9 Añade bienvenida y herramientas
* 226d69b Crea el manual del equipo
```

`nueva-pagina-faq` ha avanzado dos commits; `main` sigue en `dfed5ec`. Quien esté en `main` no ve la página a medias: si Ana vuelve a `main` con `git switch main`, `docs/preguntas-frecuentes.md` desaparece de la carpeta, y reaparece al volver a la rama.

### 4. La rama en GitLab

Para que el equipo la vea, Ana publica la rama con `git push -u origin nueva-pagina-faq`. GitLab responde con el enlace para abrir una merge request (eso es el M04):

```text
remote:
remote: To create a merge request for nueva-pagina-faq, visit:
remote:   http://localhost:8080/ana/manual-m03-demo/-/merge_requests/new?merge_request%5Bsource_branch%5D=nueva-pagina-faq
remote:
To gitlab:ana/manual-m03-demo.git
 * [new branch]      nueva-pagina-faq -> nueva-pagina-faq
branch 'nueva-pagina-faq' set up to track 'origin/nueva-pagina-faq'.
```

En GitLab, con la sesión de Ana, **Code → Branches** del proyecto lista dos ramas: `main`, con las etiquetas **default** y **protected**, y `nueva-pagina-faq`, con su último commit «Enlaza las preguntas frecuentes desde el índice». **Code → Repository graph** dibuja el mismo grafo que la terminal: tres commits comunes y, encima, los dos de la rama, cada nombre de rama junto al commit al que apunta.

> 📷 **Captura pendiente** · `M03-00-repository-graph.png` — GitLab, sesión de Ana: **Code → Repository graph** con la rama `nueva-pagina-faq`.

### 5. Fusión *fast-forward*

De vuelta en `main`, Ana fusiona la rama:

```bash
# 💻 Ordenador de Ana
git switch main
git merge nueva-pagina-faq
```

```text
Updating dfed5ec..8ebdb6f
Fast-forward
 README.md                    | 1 +
 docs/preguntas-frecuentes.md | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 docs/preguntas-frecuentes.md
```

```text
* 8ebdb6f (HEAD -> main, nueva-pagina-faq) Enlaza las preguntas frecuentes desde el índice
* 767c3c1 Añade la página de preguntas frecuentes
* dfed5ec (origin/main, origin/HEAD) Añade normas de trabajo y scripts de validación
* 04de6d9 Añade bienvenida y herramientas
* 226d69b Crea el manual del equipo
```

Como `main` no había cambiado desde que se creó la rama, Git no necesita mezclar nada: mueve el puntero `main` hasta `8ebdb6f`. Eso es un *fast-forward*: no hay commit nuevo y la historia sigue siendo una línea recta.

### 6. Limpieza y publicación

```bash
# 💻 Ordenador de Ana
git branch -d nueva-pagina-faq
git push
git push origin --delete nueva-pagina-faq
```

```text
Deleted branch nueva-pagina-faq (was 8ebdb6f).
```

```text
   dfed5ec..8ebdb6f  main -> main
```

```text
 - [deleted]         nueva-pagina-faq
```

Borrar la rama no borra commits: solo quita el nombre. Los dos commits siguen en `main`. En **Code → Branches** queda solo `main`, y **Code → Commits** muestra los cinco commits en línea.

### 7. El otro caso: commit de merge

Si mientras tanto alguien hubiera hecho un commit en `main` (por ejemplo, «Añade la configuración de Git al primer día»), las dos ramas tendrían commits propios y el puntero no podría simplemente avanzar. Git crea entonces un **commit de merge** con dos padres, y el grafo muestra la bifurcación y la unión:

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

| | *Fast-forward* | Commit de merge |
|---|---|---|
| Cuándo | `main` no ha cambiado desde que se creó la rama | Las dos ramas tienen commits propios |
| Commit nuevo | No | Sí, con dos padres («Merge branch '…'») |
| Grafo | Línea recta | Bifurcación y unión |

## Qué queda visto

Una rama es un nombre que apunta a un commit; `HEAD` dice en qué rama se trabaja; cada commit hace avanzar solo la rama actual. La fusión mueve el puntero (*fast-forward*) o crea un commit de merge, según haya cambiado o no la rama de destino. El caso con commit de merge se practica en [01 — Lab — Rama y merge](01-lab-rama-y-merge.md), que se puede hacer sin haber seguido esta demostración.
