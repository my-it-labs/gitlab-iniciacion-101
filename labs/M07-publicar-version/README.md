# M07 — Publicar una versión

[← Página anterior](../M06-flujo-completo/01-lab-flujo-completo.md) · [Siguiente página →](00-imagen-y-release.md)

El artefacto del pipeline es un archivo que caduca. Una versión del proyecto es otra cosa: una imagen Docker que se puede ejecutar, y una release que le pone nombre, tag y texto. Aquí el pipeline hace las dos.

## Qué aprenderás

- Empaquetar el documento generado (`public/manual-completo.md`) en una imagen Docker
- Publicar esa imagen en el registro del proyecto desde un job
- Separar el tag de la imagen (`latest`) del tag de Git (`v1.0.0`)
- Hacer que un tag de Git cree la release en GitLab

## Teoría

| Pieza | Qué es aquí |
|-------|-------------|
| **Artefacto** | `public/manual-completo.md`, guardado por el job `construir-manual`. Se descarga y caduca |
| **Imagen** | Ese mismo documento metido en un contenedor. `docker run` lo imprime |
| **Registro** | Dónde GitLab guarda las imágenes del proyecto. En el entorno es `gitlab:5050` |
| **Tag de la imagen** | Nombre de una publicación concreta: `latest`, o `v1.0.0` |
| **Tag de Git** | Nombre que apunta a un commit, por ejemplo `v1.0.0`. No es una rama |
| **Release** | Ficha de esa versión en GitLab: el tag, un título y un texto. La crea el pipeline |

El nombre `v1.0.0` se usa en los dos sitios a propósito: el tag de Git dice qué commit es la versión, y el tag de la imagen dice qué publicación corresponde a ese commit.

```yaml
publicar-release:
  stage: version
  rules:
    - if: $CI_COMMIT_TAG
```

`rules` decide si el job entra en el pipeline. Con `$CI_COMMIT_TAG`, entra cuando el pipeline es el de un tag. Un push a `main` deja el pipeline en tres stages (`validar`, `construir`, `publicar`). El tag añade la stage `version`.

> [!NOTE]
> Dentro de la red del entorno el servidor se llama `gitlab`. El navegador usa `http://localhost:8080`. Un job que llama a la API usa `http://gitlab:8080`. El registro, en los dos sitios, es `gitlab:5050`. Lo deja listo el arranque del [entorno de prácticas](../../infra/README.md), en «Registro de imágenes».

## Páginas

<!-- gen:paginas -->
| # | Página | Qué hay |
|---|--------|---------|
| 00 | [De la imagen a la release](00-imagen-y-release.md) | Demostración: el tag v1.0.0 publica la imagen y deja la release |
| 01 | [Lab — Imagen del proyecto](01-lab-imagen.md) | Escribes el Dockerfile y el job que publica la imagen en el registro |
| 02 | [Lab — Release](02-lab-release.md) | Etiquetas v1.0.0 y el pipeline crea la release con la imagen de esa versión |

→ Empieza por **[00 — De la imagen a la release](00-imagen-y-release.md)**.
<!-- /gen:paginas -->
