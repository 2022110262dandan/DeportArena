# Diario del Proyecto

## 1. Objetivo
Organizar `DeportArena` como una aplicación web estática mantenible, separando el HTML, CSS y JavaScript, eliminando duplicaciones y dejando preparado el proyecto para compilarse y desplegarse.

## 2. Estructura actual
- `htmls/`: ocho vistas HTML: inicio, campos, reservar, sala de partido, perfil, panel de administración, agenda y caja.
- `assets/css/`: estilos globales, estilos específicos por página y archivos de entrada/salida de Tailwind.
- `assets/js/`: configuración compartida de Tailwind, lógica global y scripts específicos por página.
- `bd.sql`: base de datos del proyecto.
- `README.md`, `package.json` y `vercel.json`: documentación y configuración de instalación, compilación y despliegue.

## 3. Avances realizados

### 3.1. Separación de estilos y scripts
- Se extrajo el CSS inline de las páginas HTML a archivos individuales dentro de `assets/css/`.
- Se extrajo el JavaScript inline a archivos individuales dentro de `assets/js/`.
- Se conservaron los estilos y comportamientos propios de cada vista sin mezclar su lógica específica.

### 3.2. Archivos específicos creados
- CSS: `index.css`, `agenda_admin.css`, `caja_admin.css`, `campos.css`, `panel_admin.css`, `perfil.css`, `reservar.css` y `sala_partido.css`.
- JavaScript: `index.js`, `agenda_admin.js`, `caja_admin.js`, `campos.js`, `panel_admin.js`, `perfil.js`, `reservar.js` y `sala_partido.js`.

### 3.3. Corrección y verificación de rutas
- Las páginas HTML se actualizaron para cargar sus hojas de estilo y scripts externos mediante rutas relativas desde `htmls/`, por ejemplo `../assets/css/...` y `../assets/js/...`.
- Se revisaron especialmente `reservar.html` y `sala_partido.html`, que inicialmente requerían actualizar sus referencias.
- Se corrigió en `agenda_admin.html` un tag `<script>` extra antes de cargar `agenda_admin.js`.
- Se comprobó que `agenda_admin.js` contiene la función `togglePanel()` utilizada por esa vista.

### 3.4. Consolidación de estilos compartidos
- Se creó `assets/css/global.css` con reglas reutilizables:
  - configuración de `.material-symbols-outlined`;
  - estilos de `.glass-card` y `.glass-effect`;
  - scrollbars personalizados y ocultos;
  - transición y elevación de `.pitch-card-hover`.

### 3.5. Consolidación de JavaScript compartido
- Se creó `assets/js/global.js` para centralizar comportamientos comunes:
  - efecto de foco en campos de búsqueda;
  - lógica de notificaciones y toasts.
- Las ocho páginas incluyen el script global además de su script específico.

### 3.6. Tailwind y compilación local
- Se creó `assets/js/tailwind-config.js` con la configuración común de Tailwind: colores, tipografías, tamaños, radios y espaciados del sistema visual.
- Se creó `assets/css/tailwind-input.css` como entrada y `assets/css/tailwind.css` como salida compilada.
- Se dejó de depender del CDN de Tailwind en las páginas: todas cargan `../assets/css/tailwind.css`.
- Se configuró `package.json` con `tailwindcss` como dependencia de desarrollo y el comando `npm run build` para generar el CSS minificado.
- `vercel.json` quedó preparado para que Vercel ejecute la compilación antes del despliegue.

### 3.7. Documentación
- Se actualizó `README.md` con los pasos básicos:
  1. ejecutar `npm install`;
  2. ejecutar `npm run build`;
  3. comprobar que se genere `assets/css/tailwind.css`.
- Se documentó que el proyecto está pensado para desplegarse en Vercel.

### 3.8. Limpieza realizada y observaciones
- Se eliminaron referencias duplicadas a `Material Symbols` en los encabezados.
- Se verificó que las páginas ya no carguen Tailwind desde `https://cdn.tailwindcss.com`.
- Durante la última revisión todavía se observan referencias duplicadas a `global.css` en varias páginas. Deben eliminarse y volver a comprobarse antes de considerar terminada la limpieza.

## 4. Estado actual
- La separación de responsabilidades está implementada.
- La configuración de Tailwind está centralizada y la compilación local está preparada.
- Las ocho vistas tienen sus assets específicos y los recursos globales conectados.
- La compilación y el funcionamiento visual completo en navegador aún necesitan una validación final.

## 5. Próximos pasos del frontend
1. Ejecutar `npm install` y `npm run build` desde la raíz.
2. Levantar un servidor estático local y probar las ocho páginas.
3. Revisar la consola del navegador, las rutas de assets y los errores JavaScript.
4. Comprobar búsqueda, notificaciones, paneles, agenda, reservas, selección de campos y sala de partido.
5. Verificar el diseño responsive en móvil, tablet y escritorio.

## 6. Archivos clave
- `assets/css/global.css`
- `assets/css/tailwind-input.css`
- `assets/css/tailwind.css`
- `assets/js/global.js`
- `assets/js/tailwind-config.js`
- `package.json`
- `README.md`
- `vercel.json`

## 7. Actualización de base de datos v2
- Se reemplazó el modelo inicial por `bd.sql` v2 para PostgreSQL/Supabase.
- Se separaron los usuarios generales de la administración mediante roles y membresías.
- Se añadieron `organizaciones`, `sedes`, `miembros_organizacion` y `miembros_sede` para soportar múltiples complejos.
- Se añadió `administradores_cancha` para asignar una cuenta de correo de Supabase Auth a una cancha específica.
- Los correos y credenciales permanecen en `auth.users`; no se duplican en tablas públicas.
- Se añadieron estados operativos de reserva, restricciones contra solapamientos activos y eliminación no destructiva de canchas.
- Se separaron `pagos` y `reembolsos` de las reservas.
- Se normalizaron equipos y jugadores mediante `equipos` y `equipo_jugadores`.
- Se añadieron invitaciones con expiración, auditoría, índices y timestamps de actualización.
- Se reforzó el trigger de creación de perfiles con `security definer`, `search_path` y protección contra duplicados.

## 8. Próximos pasos inmediatos
1. Crear el proyecto Supabase de desarrollo.
2. Ejecutar y probar `bd.sql` v2 en ese entorno; si existe una base anterior, preparar una migración controlada.
3. Crear un usuario general y una cuenta administrativa con correo específico.
4. Asignar el administrador a una sede o cancha mediante `miembros_sede` o `administradores_cancha`.
5. Implementar RLS para que cada usuario vea solo sus datos y cada administrador opere únicamente sus recursos.
6. Conectar autenticación, catálogo, disponibilidad y creación transaccional de reservas.
7. Probar específicamente que un administrador de una cancha no pueda consultar ni modificar otra cancha.
8. Añadir una migración de enums si el proyecto Supabase ya contiene el esquema v1.

## 9. Nota
El proyecto cuenta con un frontend estático desplegado y una base de datos v2 diseñada para crecer. La prioridad actual es probar la separación de permisos y conectar el primer flujo real de autenticación y reserva.

