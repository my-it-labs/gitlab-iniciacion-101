# M06 — Ejercicio integrador y buenas prácticas

[← Página anterior](../M05-gitlab-ci-cd/03-lab-fallo-controlado.md) · [Siguiente página →](00-flujo-completo.md)

Llega una tarea real para el proyecto. La haces entera tú solo, sin guía fina: la registras, la trabajas en su rama, la propones, compruebas el pipeline y la integras con un historial que se entienda.

## Qué aprenderás

- Encadenar issue, rama, commits, push, merge request, pipeline y fusión sin consultar los módulos anteriores
- Organizar el repositorio para que alguien nuevo encuentre las cosas
- Dejar un historial en el que cada commit cuente una cosa
- Reconocer los errores habituales antes de cometerlos

## Teoría

El recorrido completo de un cambio:

| Paso | Dónde | Resultado |
|------|-------|-----------|
| 1. Registrar la tarea | GitLab → Issues | Issue con número |
| 2. Crear la rama | Git o la propia issue | Rama con nombre que remite a la issue |
| 3. Hacer el cambio en commits | Editor + Git, en el ordenador de quien hace el cambio | Commits pequeños con mensajes claros |
| 4. Publicar | `git push` | Rama en GitLab y pipeline lanzado |
| 5. Proponer | GitLab → Merge requests | MR enlazada con `Closes #n` |
| 6. Revisar | MR | Comentarios resueltos y pipeline en verde |
| 7. Fusionar | MR | Cambio en `main`, issue cerrada, rama borrada |

> [!NOTE]
> Si un paso falla, no vuelvas a empezar. Cada paso deja algo visible en GitLab, y desde ahí se retoma.

## Páginas

<!-- gen:paginas -->
| # | Página | Qué hay |
|---|--------|---------|
| 00 | [El flujo completo y los errores habituales](00-flujo-completo.md) | Organización del repositorio, historial claro y lo que suele salir mal |
| 01 | [Lab — Flujo completo](01-lab-flujo-completo.md) | Una tarea del proyecto, de la issue a la fusión con el pipeline en verde |

→ Empieza por **[00 — El flujo completo y los errores habituales](00-flujo-completo.md)**.
<!-- /gen:paginas -->
