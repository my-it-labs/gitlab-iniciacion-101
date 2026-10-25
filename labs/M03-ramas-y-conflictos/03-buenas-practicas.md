# Buenas prácticas de commits y ramas

[← Página anterior](02-lab-conflicto.md) · [Siguiente página →](../M04-trabajo-colaborativo/README.md)

El historial del manual del equipo es la respuesta a preguntas como «¿cuándo cambió el horario y por qué?» o «¿qué rama está tocando las normas de vacaciones?». Esa respuesta solo sirve si los mensajes de commit y los nombres de rama dicen algo. Esta página reúne las convenciones que usa el curso y que encontrarás en la mayoría de equipos.

## Mensajes de commit

Un buen mensaje permite entender el cambio sin abrir el diff. Tres reglas cubren casi todos los casos.

### 1. Verbo en presente, como una orden

La primera línea (el **asunto**) describe lo que hace el commit si se aplica: «Añade…», «Corrige…», «Enlaza…». Es la misma forma que usa Git en sus propios mensajes (`Merge branch 'pagina-faq'`). Va con mayúscula inicial, sin punto final y corta: que quepa entera en `git log --oneline` y en la lista de **Code → Commits** de GitLab.

El historial de partida del manual ya sigue esta regla:

```text
a915cab Añade normas de trabajo y scripts de validación
54bcf5a Añade bienvenida y herramientas
31ce040 Crea el manual del equipo
```

### 2. Una cosa por commit

Un commit agrupa un cambio con sentido propio. Si para describirlo necesitas «y además…», probablemente son dos commits. En el lab de ramas, la página de preguntas frecuentes y su enlace en el índice fueron dos commits:

```text
8496533 Enlaza las preguntas frecuentes desde el índice
9bc5423 Añade la página de preguntas frecuentes
```

Así, si hubiera que quitar el enlace, se revierte un commit sin tocar la página.

### 3. Cuerpo cuando el porqué no es evidente

El asunto dice **qué** cambia; el **cuerpo**, separado por una línea en blanco, dice **por qué**. No hace falta en cada commit, pero sí cuando el motivo no se deduce del cambio: un acuerdo de equipo, un error que se corrige, una decisión que alguien querrá entender dentro de un año.

```text
commit 57364c872d48fa6d9efe69730674540ec57d2159
Author: Ana <ana@equipo.local>
Date:   Sun Oct 25 10:03:43 2026 +0100

    Amplía el preaviso de vacaciones a tres semanas
    
    En verano coinciden muchas solicitudes y dos semanas no daban margen
    para organizar los turnos. Acordado en la reunión de equipo del lunes.
```

Para escribir un cuerpo se usa `git commit` sin `-m`: se abre el editor con asunto, línea en blanco y cuerpo. Desde la terminal también vale repetir `-m`: `git commit -m "Asunto" -m "Cuerpo"`.

### Ejemplos

| Mal | Por qué | Mejor |
|-----|---------|-------|
| `cambios` | No dice qué ni dónde | `Adelanta el horario de referencia a las 8:00` |
| `arreglo` | ¿Qué se arregla? | `Corrige el enlace a herramientas en la bienvenida` |
| `faq y horario y typo` | Tres cambios mezclados | Tres commits: `Añade la página de preguntas frecuentes`, `Amplía la flexibilidad del horario a la salida`, `Corrige una errata en vacaciones` |
| `He añadido la página nueva.` | Pasado, con punto, y «la página nueva» no dice cuál | `Añade la página de preguntas frecuentes` |
| `wip` | Trabajo a medias publicado sin explicación | Termina el cambio en tu rama y confírmalo con un mensaje que lo describa |
| `Merge branch 'flexibilidad-salida'` | Este sí está bien: es el mensaje que propone Git para un merge | Déjalo tal cual |

> [!TIP]
> Una prueba rápida: completa la frase «Si aplico este commit, …» con el asunto. «Si aplico este commit, *añade la página de preguntas frecuentes*» tiene sentido; «Si aplico este commit, *cambios*», no.

## Nombres de rama

El nombre de una rama aparece en `git branch`, en **Code → Branches**, en el mensaje del merge y, en el M04, en la merge request. Tiene que decir de qué trata sin abrirla.

### Forma recomendada

| Pieza | Qué es | Ejemplos |
|-------|--------|----------|
| Tipo | Clase de cambio | `docs/` (contenido nuevo o ampliado), `fix/` (corrección), `ci/` (pipeline) |
| Número de issue | Si la tarea está registrada en una issue | `12-` |
| Descripción | Dos a cuatro palabras, en minúsculas y con guiones | `pagina-faq`, `horario-de-8` |

Se combinan según lo que use el equipo: `docs/pagina-faq`, `fix/enlace-herramientas`, `12-pagina-faq`. Lo importante es que todo el equipo use la misma forma.

> [!NOTE]
> Cuando se crea una rama desde una issue con **Create branch** (lo verás en el M04), GitLab propone el nombre con el número y el título de la issue, por ejemplo `12-anadir-preguntas-frecuentes`. Así la rama queda asociada a la issue sin tener que recordarlo.

### Ejemplos

| Mal | Por qué | Mejor |
|-----|---------|-------|
| `rama1`, `prueba`, `nueva` | No dicen nada del cambio | `docs/pagina-faq` |
| `ana` | Dice quién, no qué; y Ana tendrá más de una rama | `fix/enlace-herramientas` |
| `Cambios Horario` | Espacios y mayúsculas: Git no admite espacios en el nombre y las mayúsculas confunden en Windows | `docs/horario-de-8` |
| `cambio-del-horario-de-referencia-y-de-la-flexibilidad-a-la-salida` | Demasiado largo y mezcla dos cambios | Dos ramas: `docs/horario-de-8` y `docs/flexibilidad-salida` |
| `página-añadida` | Tildes y eñes dan problemas en algunas herramientas y URL | `docs/pagina-faq` |

> [!WARNING]
> Una rama vive poco: se crea para un cambio, se fusiona y se borra. Si una rama acumula semanas de cambios variados, los conflictos crecen y el nombre deja de describir lo que contiene.

## Resumen

| | Regla |
|---|---|
| Asunto del commit | Verbo en presente («Añade…»), mayúscula inicial, sin punto, corto |
| Contenido del commit | Un cambio con sentido propio |
| Cuerpo del commit | El porqué, cuando no es evidente, tras una línea en blanco |
| Nombre de rama | `tipo/descripcion` o `numero-descripcion`, en minúsculas, con guiones y sin tildes |
| Vida de la rama | Un cambio; se fusiona y se borra |
