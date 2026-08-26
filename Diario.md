# Diario del Proyecto

## 1. Objetivo
Crear una estructura organizada para el proyecto `DeportArena`, separando todo el CSS y JavaScript inline de las páginas HTML en archivos externos bien estructurados.

## 2. Estructura creada
- `assets/css/`
- `assets/js/`
- `htmls/`

## 3. Avances principales

### 3.1. Separación de estilos y scripts
- Extracción de CSS inline de todas las páginas HTML en archivos individuales dentro de `assets/css/`.
- Extracción de JavaScript inline de todas las páginas HTML en archivos individuales dentro de `assets/js/`.
- Creación de archivos de configuración de Tailwind por página para mantener la configuración original durante el proceso.

### 3.2. Verificación de rutas
- Actualización de las referencias en los HTML para cargar los assets externos con rutas relativas correctas (`/assets/css/...` y `/assets/js/...`).
- Revisión e identificación de `reservar.html` y `sala_partido.html` como páginas que aún necesitaban actualizar los enlaces a los assets externos.

### 3.3. Corrección de errores
- Se corrigió un error en `agenda_admin.html` donde había un tag `<script>` extra antes de la inclusión de `/assets/js/agenda_admin.js`.
- Se verificó que `assets/js/agenda_admin.js` contenía la función `togglePanel()` usada en la página.

### 3.4. Consolidación de estilos globales
- Creación de `assets/css/global.css` para reglas compartidas como:
  - `.material-symbols-outlined`
  - `.glass-card`
  - `.glass-effect`
  - scrollbars personalizados
  - animaciones de tarjetas (`.pitch-card-hover`)

### 3.5. Consolidación de scripts globales
- Creación de `assets/js/global.js` para comportamientos compartidos como:
  - efecto de foco en campos de búsqueda
  - lógica de notificaciones/toasts

### 3.6. Consolidación de Tailwind
- Creación de `assets/js/tailwind-config.js` con la configuración de Tailwind común a todas las páginas.
- Se identificó que todos los archivos `*-tailwind-config.js` tienen la misma configuración.

### 3.7. Limpieza de recursos duplicados
- Se eliminaron referencias duplicadas a `Material Symbols` en los encabezados de los HTML.
- Se verificó que cada HTML cargara Tailwind CDN solo una vez.

## 4. Tareas restantes / próximos pasos
- Actualizar los HTML para que usen `assets/js/tailwind-config.js` en lugar de los archivos `*-tailwind-config.js` individuales. (Completado)
- Cambiar todos los HTML para incluir `assets/css/global.css` y `assets/js/global.js`. (Completado)
- Eliminar los archivos `*-tailwind-config.js` redundantes si ya no se usan. (Completado)
- Revisar el contenido de cada archivo CSS específico por página y mover a `global.css` las reglas que se repiten.
- Revisar el contenido de cada archivo JS específico por página y mover a `global.js` la lógica repetida.
- Verificar en el navegador que todas las páginas cargan correctamente sin errores en consola.

## 5. Archivos clave generados hasta ahora
- `assets/css/global.css`
- `assets/js/global.js`
- `assets/js/tailwind-config.js`
- `assets/js/index.js`
- `assets/js/agenda_admin.js`
- `assets/js/caja_admin.js`
- `assets/js/campos.js`
- `assets/js/panel_admin.js`
- `assets/js/perfil.js`
- `assets/js/reservar.js`
- `assets/js/sala_partido.js`
- `assets/css/index.css`
- `assets/css/agenda_admin.css`
- `assets/css/caja_admin.css`
- `assets/css/campos.css`
- `assets/css/panel_admin.css`
- `assets/css/perfil.css`
- `assets/css/reservar.css`
- `assets/css/sala_partido.css`

## 6. Notas adicionales
- El proyecto está bien encaminado hacia una estructura estática viable.
- La parte más importante ahora es terminar la normalización global y eliminar las duplicaciones.
- Después de eso, el proyecto podrá ser probado localmente con un servidor estático y documentado con un `README.md`.

