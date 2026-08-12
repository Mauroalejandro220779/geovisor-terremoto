# Dónde Donar — Terremoto Colombia 7,4

Geovisor con puntos de acopio y donación para el terremoto de magnitud 7,4 en Colombia (agosto de 2026). Muestra en un mapa qué insumos necesita cada centro, permite filtrar por categoría y departamento, y enlaza a la fuente de cada dato.

**Sitio en vivo:** https://dondedonar.socratesdata.org/

## Qué hace

- Mapa interactivo (Leaflet + OpenStreetMap) con los centros de acopio activos.
- Filtros por tipo de insumo (agua y alimentos, aseo, abrigo, rescate, insumos médicos/sangre, mascotas, niños y bebés) y por departamento.
- Lista lateral sincronizada con el mapa; cada punto muestra dirección, insumos requeridos, teléfono/WhatsApp (cuando se conoce), fuente y fecha de actualización.
- Página de [Términos de uso](terminos.html).

## Origen de los datos

La información se recopila manualmente a partir de comunicados oficiales (alcaldías, gobernaciones, Cruz Roja Colombiana) y cobertura de prensa verificada (El Tiempo, Infobae, El País, Semana, entre otros). **No es un canal oficial** de las entidades a cargo de la emergencia — verifica siempre con el punto de acopio antes de desplazarte o donar. Ver [terminos.html](terminos.html) para más detalle.

## Estructura del proyecto

```
index.html      → app principal (mapa, filtros, datos en el array POINTS)
terminos.html   → términos de uso
styles.css      → paleta de colores compartida (variables :root)
CNAME           → dominio personalizado para GitHub Pages
```

Los puntos de donación viven en el array `POINTS` dentro de `index.html`. Cada punto tiene: `name`, `dept`, `addr`, `lat`, `lng`, `cats`, `source`, `sourceUrl`, `updated`, y opcionalmente `phone` y `note`.

## Desarrollo local

Es un sitio estático sin build step. Basta con abrir `index.html` en el navegador, o servirlo con cualquier servidor estático:

```
npx serve .
```

## Despliegue

Se publica automáticamente vía GitHub Pages desde la rama `master`.

## Contacto

Reporta un centro de acopio o corrige un dato desde el footer del sitio, o escribe a mauroalejandro@gmail.com.

---

Hecho con ♥ por Mauro Reyes Bonilla · [Socrates Data](https://socratesdata.org)
