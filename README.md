# DeportArena

Plataforma digital para descubrir, reservar y administrar canchas deportivas. DeportArena busca convertir la gestión de complejos deportivos en una operación centralizada, medible y escalable, mientras ofrece a los jugadores una experiencia rápida para encontrar un espacio, coordinar un partido y administrar su participación.

> **Estado actual:** frontend estático desplegado en Vercel y modelo de datos v2 preparado para Supabase, con administración separada de usuarios generales y administradores asignados por sede o por cancha.

## 1. Concepto del proyecto

DeportArena conecta tres necesidades dentro de un mismo producto:

- **Jugadores:** descubrir canchas, consultar disponibilidad, reservar horarios, invitar participantes y gestionar su perfil.
- **Capitanes y equipos:** organizar partidos, confirmar asistencia y distribuir jugadores entre equipos.
- **Administradores de complejos:** gestionar canchas, tarifas, agenda, bloqueos, cobros, reservas y métricas del negocio.

El objetivo no es únicamente mostrar una agenda. La visión es crear la infraestructura operativa de un complejo deportivo: disponibilidad confiable, reserva sin fricción, control financiero, comunicación con los jugadores y datos para tomar decisiones.

## 2. Visión a largo plazo

DeportArena debe evolucionar desde un prototipo de reserva hacia una plataforma multi-complejo y multi-ciudad, preparada para:

- incorporar distintos deportes y formatos de cancha;
- permitir que varios complejos administren sus propias operaciones;
- ofrecer reservas web y, posteriormente, aplicaciones móviles;
- sincronizar pagos, disponibilidad y notificaciones en tiempo real;
- automatizar recordatorios, confirmaciones y recuperación de clientes;
- generar analítica de ocupación, ingresos, horarios pico y recurrencia;
- integrarse con proveedores de pagos, calendarios, mapas y herramientas de comunicación.

La dirección de producto debe mantener una idea central: **hacer que reservar y operar una cancha sea tan claro como consultar un calendario, pero con la profundidad necesaria para administrar un negocio completo**.

## 3. Objetivos

### Objetivo general

Construir una plataforma confiable para la gestión integral de reservas deportivas, con una experiencia sencilla para el jugador y herramientas profesionales para el administrador.

### Objetivos específicos

1. Reducir el tiempo necesario para encontrar y reservar una cancha.
2. Evitar conflictos de disponibilidad y errores de agenda.
3. Centralizar pagos, bloqueos, tarifas y reservas en una sola operación.
4. Facilitar la creación y coordinación de partidos.
5. Proporcionar información útil para mejorar la ocupación y la rentabilidad.
6. Diseñar una base técnica capaz de crecer sin rehacer el producto desde cero.

## 4. Comienzo y planteamiento del MVP

El proyecto comenzó como una interfaz estática orientada a validar el concepto, la navegación y los flujos principales antes de conectar servicios externos. En esta etapa se trabajó en:

- separar el HTML de los estilos y scripts inline;
- crear una estructura de páginas y recursos mantenible;
- definir una identidad visual consistente;
- representar los flujos de búsqueda, reserva, perfil, administración y sala de partido;
- preparar Tailwind CSS para compilación local;
- diseñar un modelo de datos relacional para una futura integración con PostgreSQL/Supabase.
- preparar el proyecto para despliegue continuo en Vercel.

Esta separación permite validar primero la experiencia de usuario y después conectar autenticación, persistencia y reglas de negocio con cambios controlados.

## 5. Funcionalidades

### 5.1. Funcionalidades representadas actualmente

- Página de inicio con propuesta de valor y acceso a la búsqueda.
- Catálogo de canchas con información visual y acciones de reserva.
- Flujo de selección de fecha, horario y cancha.
- Perfil de jugador con posiciones preferidas.
- Sala de partido para coordinar participantes y equipos.
- Panel administrativo con indicadores y accesos operativos.
- Agenda maestra para visualizar y administrar reservas.
- Caja administrativa para consultar cobros y registrar pagos.
- Notificaciones, toasts y estados visuales compartidos.
- Diseño responsive para móvil, tablet y escritorio.
- Despliegue público configurado mediante Vercel.

### 5.2. Funcionalidades objetivo del producto conectado

#### Jugadores

- Registro, inicio de sesión y recuperación de cuenta.
- Perfil con nombre, avatar y posiciones preferidas.
- Búsqueda por ubicación, deporte, tipo de cancha, fecha y precio.
- Consulta de disponibilidad en tiempo real.
- Reserva y confirmación de horario.
- Historial de reservas y cancelaciones.
- Invitación de jugadores mediante enlace o código.
- Confirmación, rechazo o estado pendiente de asistencia.
- Gestión de preferencias y notificaciones.

#### Partidos

- Creación de una sala asociada a una reserva.
- Invitación de participantes.
- Selección de posición futbolística.
- Organización de equipos mediante drag and drop.
- Bloqueo de equipos cuando el capitán finaliza la formación.
- Estado de asistencia por participante.
- Recordatorios previos al partido.

#### Administración

- Alta, edición, activación y desactivación de canchas.
- Definición de superficie, formato, capacidad y si la cancha es techada.
- Configuración de tarifas por día y franja horaria.
- Agenda diaria, semanal y mensual.
- Bloqueos por mantenimiento o reservas telefónicas.
- Registro de pagos en efectivo, tarjeta, transferencia u online.
- Control de pagos pendientes, parciales y pagados.
- Panel de ingresos, ocupación y próximas reservas.
- Gestión de usuarios y permisos.
- Auditoría de cambios relevantes.

## 6. Diseño y experiencia de usuario

La dirección visual se basa en una interfaz deportiva corporativa: energética, clara y orientada a tareas frecuentes. El verde representa acción, disponibilidad y éxito; los azules funcionan como acentos informativos; los tonos neutros sostienen la legibilidad y la jerarquía.

Principios de diseño:

- priorizar la disponibilidad, la fecha, el horario y el precio;
- mantener recorridos cortos para reservar;
- diferenciar con claridad los estados confirmado, pendiente, rechazado, bloqueado y pagado;
- utilizar tarjetas y paneles solo cuando aporten agrupación funcional;
- mantener una jerarquía visual consistente entre el producto del jugador y el panel administrativo;
- diseñar primero componentes reutilizables y después pantallas completas;
- mantener navegación y controles utilizables en pantallas pequeñas;
- incluir estados vacíos, carga, error, éxito y falta de disponibilidad.

La especificación visual de referencia se encuentra en [pitch_ready/DESIGN.md](pitch_ready/DESIGN.md).

## 7. Arquitectura actual

### Frontend actual

El frontend es HTML, CSS y JavaScript sin framework, organizado por vista:

```text
htmls/
	index.html
	campos.html
	reservar.html
	sala_partido.html
	perfil.html
	panel_admin.html
	agenda_admin.html
	caja_admin.html

assets/
	css/
		tailwind-input.css
		tailwind.css
		global.css
		<estilos-especificos>.css
	js/
		tailwind-config.js
		global.js
		<scripts-especificos>.js
```

`global.css` concentra estilos compartidos y `global.js` concentra comportamientos comunes. Cada página mantiene su CSS y JavaScript específico para reducir acoplamiento.

Las rutas de los assets se resolvieron con referencias relativas desde `htmls/`. Cada vista carga una sola vez Tailwind compilado, los estilos globales, sus estilos específicos, el script global y su script específico. La revisión confirmó que no existen referencias duplicadas ni referencias al CDN de Tailwind.

### Backend objetivo

El archivo [bd.sql](bd.sql) define el modelo v2 para PostgreSQL y utiliza `auth.users`, por lo que la integración prevista encaja especialmente bien con Supabase:

- autenticación administrada por Supabase Auth;
- PostgreSQL para la información del negocio;
- políticas de seguridad a nivel de fila (RLS);
- almacenamiento para avatares e imágenes de canchas;
- funciones y triggers para automatizaciones de datos;
- canales realtime para disponibilidad y actualizaciones operativas.

Los usuarios generales se registran como jugadores. Los administradores utilizan cuentas de correo creadas en Supabase Auth y reciben permisos mediante `miembros_sede` para una sede completa o `administradores_cancha` para una cancha concreta. El correo no se duplica en las tablas públicas.

El frontend no debe conectarse directamente con credenciales privilegiadas. Las operaciones sensibles deben validarse mediante políticas RLS, funciones SQL seguras o un backend controlado.

## 8. Modelo de datos inicial

El esquema actual contempla:

- `profiles`: perfil del jugador, posiciones preferidas y rol administrativo.
- `canchas`: características, capacidad y estado de cada cancha.
- `organizaciones` y `sedes`: separación del negocio y sus ubicaciones para soportar múltiples complejos.
- `miembros_sede` y `administradores_cancha`: roles administrativos asignados por sede o por cancha.
- `tarifas_cancha`: precios por día y franja horaria.
- `reservas`: fecha, horario, estado operativo, usuario, precio, bloqueo y enlace de invitación.
- `pagos` y `reembolsos`: movimientos financieros separados de la reserva.
- `partidos_sala`: sala asociada a una reserva y estructura de los equipos.
- `partido_jugadores`: participantes, posición elegida y estado de asistencia.
- `equipos` y `equipo_jugadores`: equipos normalizados sin depender únicamente de JSONB.
- `invitaciones_partido` y `auditoria`: invitaciones controladas y trazabilidad administrativa.

También se definieron enums para posiciones, asistencia, formato de cancha, métodos de pago y estados de pago. El trigger `handle_new_user` crea automáticamente un perfil cuando se registra un usuario en Auth.

La v2 ya incorpora índices, timestamps de actualización, auditoría y una restricción PostgreSQL contra solapamientos de reservas activas. Antes de producción todavía deben añadirse y probarse las políticas RLS, las migraciones desde cualquier base anterior y las reglas de negocio de pagos.

## 9. Plan de desarrollo por fases

### Fase 0: Validación y alcance

- Confirmar usuarios objetivo y reglas reales del negocio.
- Definir deportes, formatos, monedas, impuestos y políticas de cancelación.
- Priorizar el MVP y documentar criterios de aceptación.
- Validar el prototipo con jugadores y administradores.

### Fase 1: Fundación técnica

- Crear el proyecto de Supabase y aplicar `bd.sql` v2 en un entorno de desarrollo.
- Crear las cuentas de administración en Auth y asignarlas mediante `administradores_cancha` o `miembros_sede`.
- Configurar variables de entorno y separación entre desarrollo, pruebas y producción.
- Implementar autenticación y perfiles.
- Añadir RLS y roles de jugador, capitán y administrador.
- Definir una capa de acceso a datos y manejo uniforme de errores.

### Fase 2: Reserva funcional

- Conectar el catálogo de canchas con datos reales.
- Implementar disponibilidad basada en tarifas y reservas existentes.
- Crear reservas transaccionales sin solapamientos.
- Añadir confirmación, cancelación y políticas de expiración.
- Implementar historial de reservas.

### Fase 3: Operación del complejo

- Conectar agenda y caja al backend.
- Implementar mantenimiento, bloqueos y reservas manuales.
- Añadir registro de pagos y conciliación.
- Crear métricas de ocupación e ingresos.
- Añadir auditoría de acciones administrativas.

### Fase 4: Sala de partido y comunicación

- Persistir participantes y formación de equipos.
- Añadir enlaces de invitación seguros y con caducidad.
- Enviar recordatorios por correo y, posteriormente, otros canales.
- Implementar actualizaciones en tiempo real de asistencia y equipos.

### Fase 5: Escalamiento de producto

- Convertir el modelo en multi-tenant para varios complejos.
- Añadir organizaciones, sedes y membresías con permisos granulares.
- Incorporar pagos online y reembolsos.
- Publicar API versionada para aplicaciones móviles e integraciones.
- Incorporar observabilidad, analítica avanzada y automatizaciones.

## 10. Escalabilidad y arquitectura objetivo

Para crecer de un complejo a múltiples clientes, la plataforma debe separar claramente:

- **Identidad:** usuarios, sesiones, roles y permisos.
- **Tenancy:** organización, sede y recursos pertenecientes a cada cliente.
- **Catálogo:** deportes, canchas, características y tarifas.
- **Disponibilidad:** reglas horarias, reservas, bloqueos y excepciones.
- **Pagos:** órdenes, transacciones, estados, comprobantes y reembolsos.
- **Partidos:** salas, invitaciones, participantes y equipos.
- **Comunicaciones:** plantillas, preferencias, colas y registros de entrega.
- **Analítica:** eventos de producto, ocupación, conversión e ingresos.

Principios técnicos para escalar:

1. Mantener la base de datos como fuente de verdad para disponibilidad y pagos.
2. Usar transacciones e índices adecuados para evitar reservas duplicadas.
3. Separar lecturas de catálogo y disponibilidad cuando el volumen lo requiera.
4. Introducir cache solo donde no comprometa la exactitud de la disponibilidad.
5. Procesar notificaciones, imágenes y tareas pesadas de forma asíncrona.
6. Versionar la API y las migraciones de base de datos.
7. Registrar métricas, logs estructurados y trazas desde las primeras versiones conectadas.
8. Diseñar permisos por organización y sede desde el inicio del modo multi-tenant.

## 11. Seguridad y calidad

La versión de producción debe contemplar:

- validación de entradas en frontend y backend;
- RLS para impedir acceso entre organizaciones o usuarios no autorizados;
- protección de enlaces de invitación mediante tokens no predecibles, expiración y revocación;
- nunca exponer claves privadas en el frontend;
- control de permisos para operaciones administrativas y financieras;
- protección contra doble envío y pagos repetidos mediante idempotencia;
- backups y procedimiento de recuperación;
- registro de acciones críticas;
- cumplimiento de políticas de privacidad y tratamiento de datos personales;
- pruebas automatizadas de reglas de reserva y autorización.

## 12. Pruebas y criterios de aceptación

Antes de cada publicación se debe comprobar:

- instalación limpia con `npm install`;
- compilación correcta con `npm run build`;
- carga de las ocho vistas y todos sus assets;
- ausencia de errores JavaScript en consola;
- navegación y rutas de despliegue;
- comportamiento responsive en móvil, tablet y escritorio;
- selección de fechas y horarios;
- prevención de horarios ocupados;
- creación, cancelación y consulta de reservas;
- permisos de jugador y administrador;
- pagos pendientes, parciales y pagados;
- invitaciones, asistencia y formación de equipos;
- estados de carga, error, vacío y éxito.

Cuando exista backend, estas pruebas deben dividirse en unitarias, integración, contratos de API, end-to-end y pruebas de carga para la disponibilidad.

## 13. Instalación y desarrollo local

Requisitos:

- Node.js 18 o superior recomendado.
- npm.
- Un servidor estático o de desarrollo para probar las páginas.

Instalación:

```bash
npm install
npm run build
```

El comando de build usa `assets/js/tailwind-config.js` y `assets/css/tailwind-input.css` para generar `assets/css/tailwind.css` minificado.

Para probar el sitio localmente, se puede utilizar cualquier servidor estático que sirva la raíz del proyecto. La página principal es `htmls/index.html`. El proyecto ya está desplegado en Vercel: [vercel.json](vercel.json) redirige las rutas principales hacia las vistas dentro de `htmls/` y ejecuta `npm run build` antes de cada despliegue.

## 14. Despliegue

El despliegue previsto utiliza Vercel para el frontend estático. El backend, cuando se incorpore, debe configurarse mediante servicios gestionados y variables de entorno independientes por entorno.

Checklist de producción:

1. Mantener configurados el proyecto y el dominio en Vercel.
2. Añadir las variables públicas necesarias para el cliente, sin incluir secretos.
3. Configurar Supabase Auth, URLs permitidas y políticas RLS cuando se conecte el backend.
4. Ejecutar la migración v2 de base de datos en un entorno controlado.
5. Ejecutar build y pruebas automatizadas en CI.
6. Revisar logs, errores y métricas posteriores a cada despliegue.

## 15. Estructura de trabajo recomendada a futuro

Cuando el producto deje de ser un prototipo estático, conviene migrar gradualmente a una aplicación con componentes reutilizables y rutas formales, manteniendo el diseño actual como referencia. La migración debe priorizar los flujos de mayor valor: autenticación, disponibilidad, reserva y administración.

Una evolución razonable sería:

1. Mantener las páginas actuales como prototipo validado.
2. Extraer componentes de navegación, tarjetas, calendarios, estados y modales.
3. Conectar primero el catálogo y la disponibilidad.
4. Añadir autenticación y reserva transaccional.
5. Migrar progresivamente el panel administrativo y la sala de partido.
6. Añadir pruebas y observabilidad en cada módulo migrado.

## 16. Documentos del proyecto

- [Diario del proyecto](Diario.md): registro de avances, decisiones y próximos pasos.
- [Sistema de diseño](pitch_ready/DESIGN.md): colores, tipografía, espaciado y componentes.
- [Modelo de base de datos](bd.sql): esquema inicial de PostgreSQL/Supabase.
- [Configuración de compilación](package.json): dependencias y scripts npm.
- [Configuración de Vercel](vercel.json): build y rutas públicas.

## 17. Próximo hito

El siguiente hito técnico es conectar el frontend desplegado con Supabase: aplicar y probar `bd.sql` v2 en desarrollo, crear el primer usuario general y una cuenta administrativa por correo, validar sus permisos y entregar el flujo completo de consulta de disponibilidad y reserva.
Buenas buenas