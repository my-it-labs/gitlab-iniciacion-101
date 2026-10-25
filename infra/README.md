# GitLab propio para repasar

[← Volver al curso](../README.md)

Durante el curso trabajas con la instancia de GitLab que te da el formador. Si quieres repetir los laboratorios por tu cuenta, puedes levantar en tu equipo un GitLab CE con su runner. Necesitas Docker y unos 6 GB de memoria libres. También funciona en un Codespace de 4 núcleos y 16 GB abierto desde este repositorio.

## Arrancar

```bash
infra/bootstrap.sh
```

El script arranca GitLab y el runner, registra el runner y crea dos usuarios, `alumno1` y `alumno2`, con la contraseña `Formacion-2026!`. La primera vez GitLab tarda unos minutos en responder. Al terminar muestra:

```
GitLab listo: http://localhost:8080  ·  usuarios: alumno1 alumno2  ·  contraseña: Formacion-2026!
```

Si el puerto 8080 está ocupado, usa otro: `GITLAB_PORT=8929 infra/bootstrap.sh`.

## Usarlo en los laboratorios

1. Entra en `http://localhost:8080` como `alumno1`.
2. Crea tu token de acceso personal tal como explica el M01.
3. Al ejecutar `scripts/partida.sh` por primera vez, cuando te pida la URL escribe `http://localhost:8080` y después pega tu token.

Donde las páginas dicen `https://gitlab.ejemplo.com`, usa `http://localhost:8080`.

## Parar y borrar

| Qué | Comando |
|-----|---------|
| Parar, conservando los datos | `docker compose -f infra/compose.yaml stop` |
| Volver a arrancar | `docker compose -f infra/compose.yaml start` |
| Borrarlo todo y empezar de cero | `docker compose -f infra/compose.yaml down -v && rm -f infra/.env` |
