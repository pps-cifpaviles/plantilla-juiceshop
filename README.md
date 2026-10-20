# Juice Shop — plantilla del curso

[OWASP Juice Shop](https://owasp.org/www-project-juice-shop/) es una tienda online escrita en TypeScript (Node.js + Express en el servidor, Angular en el cliente) que contiene **más de cien vulnerabilidades a propósito**: inyección SQL y NoSQL, XSS, control de acceso roto, JWT débiles, SSRF, subida de ficheros… En el curso de Puesta en Producción Segura la usamos para aprender a **encontrar vulnerabilidades en el código, explotarlas, corregirlas y comprobar la corrección en el pipeline**.

> ⚠️ **Aplicación insegura.** Despliégala solo en el entorno de desarrollo del aula (`pps-dev`) y nunca la expongas a Internet.

Este repositorio es la plantilla `pps-cifpaviles/plantilla-juiceshop`. Contiene el código fuente de Juice Shop v20.3.0 (licencia MIT; el README original está en [`README-juice-shop.md`](README-juice-shop.md)) más los ficheros del curso:

| Fichero | Para qué sirve |
| --- | --- |
| `.github/workflows/pipeline.yml` | Pipeline base: build de la imagen y despliegue en desarrollo |
| `deploy/compose.yml` y `deploy/deploy.sh` | Despliegue en `pps-dev` con tu rango de puertos |
| `.github/pull_request_template.md` | Plantilla de pull request |

## Crea tu copia

```bash
gh repo create pps-cifpaviles/a07-juiceshop --template pps-cifpaviles/plantilla-juiceshop --public --clone
cd a07-juiceshop
git switch develop
```

Sustituye `07` por tu número de alumno. Tu Juice Shop queda publicado en `http://pps-dev.aula.lan:20NN20`; el alumno 07 usa el puerto 20720.

## Ejecutarla en tu equipo

Con Docker:

```bash
docker build -t juiceshop-local .
docker run --rm -p 3000:3000 juiceshop-local      # http://localhost:3000
```

Sin Docker (Node.js 22 a 24):

```bash
npm install          # instala también el frontend y lo compila; tarda varios minutos
npm start            # http://localhost:3000
```

## Estructura útil para el análisis de código

| Carpeta | Contenido |
| --- | --- |
| `routes/` | Endpoints de la API REST: aquí están la mayoría de las vulnerabilidades del servidor |
| `models/` | Modelos de datos (Sequelize sobre SQLite) |
| `lib/` | Utilidades: autenticación, `insecurity.ts`, validaciones |
| `frontend/src/` | Aplicación Angular |
| `data/static/` | Datos iniciales y retos (`challenges.yml`) |
| `server.ts` | Arranque y registro de rutas |

## Pipeline

| Evento | Jobs | Dónde |
| --- | --- | --- |
| Pull request a `develop` o `main` | `build` | Runner de GitHub |
| Push a `develop` | `build` + `deploy-dev` | Runner `pps-dev` · entorno `desarrollo` |

Durante el curso añadirás al pipeline Gitleaks, CodeQL y Semgrep (B3); dependencias, SBOM y Trivy (B4); y ZAP (B5).

## Normas de uso

- Ataca solo **tu** instancia o la que te asigne el profesor.
- Cada vulnerabilidad corregida se entrega con una pull request que explique la causa, la corrección y cómo la has comprobado.

## Colaboradores

<!-- Añade aquí tu nombre y tu usuario de GitHub. -->
