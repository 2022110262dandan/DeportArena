# DeportArena
Reserva de canchas deportivas y más...

## Desarrollo y despliegue

El proyecto usa Tailwind CSS compilado localmente para que los estilos no dependan del CDN en producción.

Desde la raíz del proyecto ejecuta:

```bash
npm install
npm run build
```

El comando genera `assets/css/tailwind.css`. Vercel ejecuta automáticamente `npm run build` mediante `vercel.json` antes de publicar el sitio.
Buenas buenas