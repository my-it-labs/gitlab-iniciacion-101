# M01 — Introducción a Git y GitLab

[← Página anterior](../../README.md) · [Siguiente página →](00-control-de-versiones.md)

El proyecto vive hoy en una carpeta compartida sin historial. Antes de llevarlo a Git necesitas saber qué guarda Git, dónde lo guarda y qué añade GitLab encima. En este tramo te sientas en los ordenadores de Ana y de Luis, configuras en cada uno quién firma los cambios, les das acceso a GitLab con una clave SSH y, con la sesión de Ana, creas el proyecto `manual-equipo`. Cómo está montado ese equipo y cómo se entra en cada ordenador: [El entorno de prácticas](../../infra/README.md).

## Qué aprenderás

- Explicar qué problema del proyecto resuelve un commit frente a la carpeta compartida
- Distinguir qué hace Git en el ordenador de cada persona y qué hace GitLab en el servidor
- Seguir un cambio por el directorio de trabajo, el área de preparación y el repositorio
- Configurar Git para que cada cambio lleve el nombre de quien lo hace, y dar acceso a GitLab con una clave SSH
- Crear `manual-equipo` en GitLab y moverte por sus secciones

## Teoría

Un **sistema de control de versiones** guarda fotos sucesivas de un conjunto de archivos. Cada foto es un **commit**: qué cambió, quién lo hizo, cuándo y por qué (el mensaje). Con eso puedes ver la historia del proyecto, volver a una versión anterior y trabajar varios a la vez sin pisaros.

| | Git | GitLab |
|---|-----|--------|
| Qué es | Programa que se ejecuta en el ordenador de cada persona | Aplicación web en un servidor |
| Qué guarda | El repositorio completo, con todo su historial, en ese ordenador | Una copia remota del repositorio que comparte el equipo |
| Qué añade | Commits, ramas, fusiones | Miembros y permisos, issues, merge requests, CI/CD |
| Funciona sin red | Sí | No |

Un cambio pasa por tres áreas antes de quedar guardado:

| Área | Qué hay | Cómo pasa a la siguiente |
|------|---------|--------------------------|
| Directorio de trabajo | Los archivos de la carpeta, tal como se editan | `git add` |
| Área de preparación (*staging*) | Lo que irá en el próximo commit | `git commit` |
| Repositorio (`.git/`) | Los commits, con su historial | — |

> [!NOTE]
> GitLab no es Git. Puedes usar Git sin GitLab (todo en local) y GitLab guarda repositorios Git. En este curso usas los dos: Git para registrar los cambios y GitLab para compartirlos y revisarlos.

## Páginas

<!-- gen:paginas -->
| # | Página | Qué hay |
|---|--------|---------|
| 00 | [Control de versiones y las tres áreas](00-control-de-versiones.md) | Demostración: un cambio en el proyecto recorre las tres áreas hasta el commit |
| 01 | [Lab — Identidad y acceso](01-lab-identidad-y-acceso.md) | Configuras Git y una clave SSH en los ordenadores de Ana y Luis y la registras en GitLab |
| 02 | [Lab — Primer proyecto](02-lab-primer-proyecto.md) | Creas `manual-equipo`, recorres sus secciones y añades el README desde la web |

→ Empieza por **[00 — Control de versiones y las tres áreas](00-control-de-versiones.md)**.
<!-- /gen:paginas -->
