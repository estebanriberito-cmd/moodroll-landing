# MOODROLL — Landing Page

## Qué es esto
Sitio estático (HTML/CSS/JS puro, sin frameworks). Abrí `index.html` en el navegador para verlo, o abrí toda la carpeta en VS Code.

## Antes de publicar, 3 cosas que tenés que reemplazar

### 1. Los archivos del Starter Pack (gratis)
Metí tus archivos reales en `assets/downloads/`, con estos nombres exactos (o cambiá el nombre en `index.html` si preferís otro):
- `FLASHBACK_2003.xmp`
- `FOOD_GLOW.xmp`
- `FREE_STARTER_PACK.pdf` (ya está copiado)

### 2. Los links de compra (Gumroad)
En `index.html` buscá las dos líneas que dicen:
```html
<a href="https://gumroad.com/" ...>
```
Reemplazá `https://gumroad.com/` por el link real de cada producto en Gumroad (uno para el pack Y2K, otro para el pack Food).

### 3. Tus redes en el footer
En `index.html`, sección `<footer>`, ya están puestos:
- `tiktok.com/@moodroll`
- `tiktok.com/@moodroll.es`
- `instagram.com/moodroll`

Confirmá que coincidan con tus usuarios reales.

## Cómo publicarlo gratis (sin Shopify, sin mensualidad)

**Opción más simple — Netlify Drop:**
1. Andá a https://app.netlify.com/drop
2. Arrastrá la carpeta `moodroll-landing` completa
3. Te da un link al toque (después podés conectar un dominio propio si querés)

**Alternativa — GitHub Pages:**
1. Subí esta carpeta a un repositorio de GitHub
2. Activá GitHub Pages en la configuración del repo
3. Listo, queda en `tuusuario.github.io/repo`

## Estructura
```
moodroll-landing/
├── index.html          → todo el contenido y estructura
├── styles.css          → colores, tipografía, layout
├── script.js           → slider interactivo + contador de scroll
├── assets/
│   ├── logo-banner.png
│   ├── logo-icon.png
│   └── downloads/       → acá van tus .xmp y PDFs
└── README.md
```

## Si querés cambiar colores o textos
Los colores están todos arriba de `styles.css`, en `:root { ... }` — cambiás un valor ahí y se actualiza en todo el sitio.
