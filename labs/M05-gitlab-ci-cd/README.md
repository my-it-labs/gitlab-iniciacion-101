# M05 — Introducción a GitLab CI/CD

[← Página anterior](../M04-trabajo-colaborativo/03-lab-revision.md) · [Siguiente página →](00-pipelines-stages-jobs.md)

Una página sin título o un enlace roto no deberían llegar al manual. Aquí añades un pipeline que comprueba las páginas en cada push y genera el manual listo para descargar. También aprendes a leer su log cuando algo falla.

## Qué aprenderás

- Hacer que cada push a `manual-equipo` se compruebe solo
- Leer un `.gitlab-ci.yml` e identificar sus stages y jobs
- Saber qué ejecuta el pipeline y dónde lo ejecuta
- Encontrar en el log por qué ha fallado un job y corregirlo
- Descargar el manual generado como artefacto de un job

## Teoría

**Integración continua (CI)**: cada cambio publicado se comprueba de forma automática. **Entrega continua (CD)**: lo que pasa las comprobaciones queda listo para publicarse. En este curso llegas a la CI y a generar el resultado. El despliegue no entra.

| Pieza | Qué es |
|-------|--------|
| `.gitlab-ci.yml` | Archivo en la raíz del repositorio que describe el pipeline |
| **Pipeline** | Una ejecución completa, lanzada por un push o una MR |
| **Stage** | Una fase. Las fases se ejecutan en orden y, si una falla, las siguientes no empiezan |
| **Job** | Una tarea dentro de una fase: unos comandos (`script`) que se ejecutan en un contenedor (`image`) |
| **Runner** | La máquina que recoge los jobs y los ejecuta. La aporta la instancia del curso |
| **Artefacto** | Archivos que guarda un job al terminar (`artifacts`) y que puedes descargar |

```yaml
stages: [validar, publicar]

comprobar-paginas:
  stage: validar
  image: alpine:3.20
  script:
    - sh scripts/validar.sh
```

> [!NOTE]
> El pipeline no se ejecuta en tu equipo ni «en GitLab» en abstracto, sino en un runner. Si un job se queda en *pending*, casi siempre es que no hay ningún runner disponible para él.

## Páginas

| # | Página | Qué hay |
|---|--------|---------|
| 00 | [Pipelines, stages y jobs](00-pipelines-stages-jobs.md) | Demostración: un `.gitlab-ci.yml` mínimo, del push al log del job |
| 01 | [Lab — Primer pipeline](01-lab-primer-pipeline.md) | Añades el job que valida las páginas y ves cómo se ejecuta tras el push |
| 02 | [Lab — Artefacto](02-lab-artefacto.md) | Generas el manual como artefacto y lo descargas |
| 03 | [Lab — Fallo controlado](03-lab-fallo-controlado.md) | Rompes el pipeline con una página sin título, lo diagnosticas por el log y lo corriges |

→ Empieza por **[00 — Pipelines, stages y jobs](00-pipelines-stages-jobs.md)**.
