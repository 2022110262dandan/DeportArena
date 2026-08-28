-- DeportArena - Modelo de datos v2 para PostgreSQL / Supabase
-- Los administradores son usuarios de auth.users asignados a una sede mediante un rol.

create extension if not exists pgcrypto;
create extension if not exists btree_gist;

do $$ begin create type public.posicion_futbol as enum ('Portero', 'Defensa', 'Centrocampista', 'Delantero'); exception when duplicate_object then null; end $$;
do $$ begin create type public.estado_asistencia as enum ('Confirmado', 'Pendiente', 'Rechazado'); exception when duplicate_object then null; end $$;
do $$ begin create type public.tipo_cancha as enum ('5v5', '7v7', '11v11', 'Padel', 'Otro'); exception when duplicate_object then null; end $$;
do $$ begin create type public.metodo_pago as enum ('Efectivo', 'Tarjeta', 'Transferencia', 'Online'); exception when duplicate_object then null; end $$;
do $$ begin create type public.estado_pago as enum ('Pendiente', 'Parcial', 'Pagado', 'Reembolsado', 'Anulado'); exception when duplicate_object then null; end $$;
do $$ begin create type public.estado_reserva as enum ('Pendiente', 'Confirmada', 'Cancelada', 'Completada', 'No_asistio', 'Expirada', 'Bloqueada'); exception when duplicate_object then null; end $$;
do $$ begin create type public.tipo_reserva as enum ('Usuario', 'Bloqueo_mantenimiento', 'Reserva_manual'); exception when duplicate_object then null; end $$;
do $$ begin create type public.rol_miembro as enum ('Propietario', 'Administrador', 'Operador_caja', 'Operador_agenda', 'Capitan', 'Jugador'); exception when duplicate_object then null; end $$;

create table if not exists public.profiles (
  id uuid references auth.users on delete cascade primary key,
  nombre text not null default 'Jugador Nuevo',
  avatar_url text,
  posiciones_preferidas public.posicion_futbol[] not null default '{}',
  creado_at timestamptz not null default now(),
  actualizado_at timestamptz not null default now()
);

create table if not exists public.organizaciones (
  id uuid primary key default gen_random_uuid(),
  nombre text not null,
  slug text not null unique,
  esta_activa boolean not null default true,
  creado_por uuid references public.profiles(id) on delete set null,
  creado_at timestamptz not null default now(),
  actualizado_at timestamptz not null default now()
);

create table if not exists public.sedes (
  id uuid primary key default gen_random_uuid(),
  organizacion_id uuid not null references public.organizaciones(id) on delete restrict,
  nombre text not null,
  direccion text,
  ciudad text,
  codigo_postal text,
  latitud numeric(9, 6),
  longitud numeric(9, 6),
  zona_horaria text not null default 'America/Bogota',
  telefono text,
  esta_activa boolean not null default true,
  creado_at timestamptz not null default now(),
  actualizado_at timestamptz not null default now(),
  unique (organizacion_id, nombre),
  check (latitud between -90 and 90),
  check (longitud between -180 and 180)
);

create table if not exists public.miembros_organizacion (
  organizacion_id uuid not null references public.organizaciones(id) on delete cascade,
  usuario_id uuid not null references public.profiles(id) on delete cascade,
  rol public.rol_miembro not null default 'Jugador',
  invitado_por uuid references public.profiles(id) on delete set null,
  creado_at timestamptz not null default now(),
  primary key (organizacion_id, usuario_id)
);

create table if not exists public.miembros_sede (
  sede_id uuid not null references public.sedes(id) on delete cascade,
  usuario_id uuid not null references public.profiles(id) on delete cascade,
  rol public.rol_miembro not null default 'Jugador',
  creado_at timestamptz not null default now(),
  primary key (sede_id, usuario_id)
);

create table if not exists public.canchas (
  id uuid primary key default gen_random_uuid(),
  sede_id uuid not null references public.sedes(id) on delete restrict,
  nombre text not null,
  tipo public.tipo_cancha not null,
  deporte text not null default 'Futbol',
  superficie text not null default 'Cesped Sintetico',
  max_jugadores integer not null,
  esta_techada boolean not null default false,
  esta_activa boolean not null default true,
  descripcion text,
  creado_por uuid references public.profiles(id) on delete set null,
  creado_at timestamptz not null default now(),
  actualizado_at timestamptz not null default now(),
  unique (sede_id, nombre),
  check (max_jugadores > 0)
);

-- Un administrador puede tener acceso a una cancha concreta mediante su usuario de Auth.
-- El correo se gestiona en auth.users; esta tabla solo guarda la asignacion y el rol.
create table if not exists public.administradores_cancha (
  cancha_id uuid not null references public.canchas(id) on delete cascade,
  usuario_id uuid not null references public.profiles(id) on delete cascade,
  rol public.rol_miembro not null default 'Administrador',
  asignado_por uuid references public.profiles(id) on delete set null,
  creado_at timestamptz not null default now(),
  primary key (cancha_id, usuario_id),
  check (rol in ('Propietario', 'Administrador', 'Operador_caja', 'Operador_agenda'))
);

create table if not exists public.tarifas_cancha (
  id uuid primary key default gen_random_uuid(),
  cancha_id uuid not null references public.canchas(id) on delete restrict,
  dia_semana smallint not null,
  hora_inicio time not null,
  hora_fin time not null,
  precio_por_hora numeric(10, 2) not null,
  moneda char(3) not null default 'COP',
  nombre_tarifa text,
  vigente_desde date not null default current_date,
  vigente_hasta date,
  creado_at timestamptz not null default now(),
  check (dia_semana between 0 and 6),
  check (hora_inicio < hora_fin),
  check (precio_por_hora >= 0),
  check (vigente_hasta is null or vigente_hasta >= vigente_desde)
);

create table if not exists public.reservas (
  id uuid primary key default gen_random_uuid(),
  cancha_id uuid not null references public.canchas(id) on delete restrict,
  usuario_id uuid references public.profiles(id) on delete set null,
  creada_por uuid references public.profiles(id) on delete set null,
  fecha date not null,
  hora_inicio time not null,
  hora_fin time not null,
  periodo tsrange generated always as (tsrange(fecha + hora_inicio, fecha + hora_fin, '[)')) stored,
  tipo public.tipo_reserva not null default 'Usuario',
  estado public.estado_reserva not null default 'Pendiente',
  motivo text,
  precio_total numeric(10, 2) not null default 0,
  estado_pago public.estado_pago not null default 'Pendiente',
  check_in_realizado boolean not null default false,
  enlace_invitacion_token uuid not null default gen_random_uuid() unique,
  invitacion_expira_at timestamptz,
  creado_at timestamptz not null default now(),
  actualizado_at timestamptz not null default now(),
  check (hora_inicio < hora_fin),
  check (precio_total >= 0),
  check (tipo = 'Usuario' or motivo is not null)
);

alter table public.reservas drop constraint if exists reservas_cancha_periodo_activo_excl;
alter table public.reservas add constraint reservas_cancha_periodo_activo_excl
  exclude using gist (cancha_id with =, periodo with &&)
  where (estado in ('Pendiente', 'Confirmada', 'Bloqueada'));

create table if not exists public.pagos (
  id uuid primary key default gen_random_uuid(),
  reserva_id uuid not null references public.reservas(id) on delete restrict,
  registrado_por uuid references public.profiles(id) on delete set null,
  monto numeric(10, 2) not null,
  metodo public.metodo_pago not null,
  estado public.estado_pago not null default 'Pagado',
  referencia_externa text,
  notas text,
  pagado_at timestamptz,
  creado_at timestamptz not null default now(),
  check (monto > 0)
);

create table if not exists public.reembolsos (
  id uuid primary key default gen_random_uuid(),
  pago_id uuid not null references public.pagos(id) on delete restrict,
  registrado_por uuid references public.profiles(id) on delete set null,
  monto numeric(10, 2) not null,
  motivo text not null,
  creado_at timestamptz not null default now(),
  check (monto > 0)
);

create table if not exists public.partidos_sala (
  id uuid primary key default gen_random_uuid(),
  reserva_id uuid not null unique references public.reservas(id) on delete cascade,
  capitan_id uuid references public.profiles(id) on delete set null,
  equipos_bloqueados boolean not null default false,
  creado_at timestamptz not null default now(),
  actualizado_at timestamptz not null default now()
);

create table if not exists public.partido_jugadores (
  id uuid primary key default gen_random_uuid(),
  partido_id uuid not null references public.partidos_sala(id) on delete cascade,
  usuario_id uuid not null references public.profiles(id) on delete cascade,
  posicion_elegida public.posicion_futbol not null,
  estado public.estado_asistencia not null default 'Pendiente',
  creado_at timestamptz not null default now(),
  actualizado_at timestamptz not null default now(),
  unique (partido_id, usuario_id)
);

create table if not exists public.equipos (
  id uuid primary key default gen_random_uuid(),
  partido_id uuid not null references public.partidos_sala(id) on delete cascade,
  nombre text not null,
  codigo text not null check (codigo in ('A', 'B')),
  creado_at timestamptz not null default now(),
  unique (partido_id, codigo)
);

create table if not exists public.equipo_jugadores (
  equipo_id uuid not null references public.equipos(id) on delete cascade,
  jugador_id uuid not null references public.partido_jugadores(id) on delete cascade,
  creado_at timestamptz not null default now(),
  primary key (equipo_id, jugador_id),
  unique (jugador_id)
);

create table if not exists public.invitaciones_partido (
  id uuid primary key default gen_random_uuid(),
  partido_id uuid not null references public.partidos_sala(id) on delete cascade,
  creado_por uuid references public.profiles(id) on delete set null,
  token uuid not null default gen_random_uuid() unique,
  expira_at timestamptz not null,
  usado_at timestamptz,
  revocada_at timestamptz,
  max_usos integer not null default 1,
  usos integer not null default 0,
  creado_at timestamptz not null default now(),
  check (max_usos > 0),
  check (usos between 0 and max_usos)
);

create table if not exists public.auditoria (
  id bigint generated always as identity primary key,
  usuario_id uuid references public.profiles(id) on delete set null,
  organizacion_id uuid references public.organizaciones(id) on delete set null,
  sede_id uuid references public.sedes(id) on delete set null,
  tabla text not null,
  registro_id uuid,
  accion text not null,
  datos jsonb,
  creado_at timestamptz not null default now()
);

create index if not exists idx_sedes_organizacion on public.sedes(organizacion_id);
create index if not exists idx_miembros_org_usuario on public.miembros_organizacion(usuario_id);
create index if not exists idx_miembros_sede_usuario on public.miembros_sede(usuario_id);
create index if not exists idx_canchas_sede_activas on public.canchas(sede_id, esta_activa);
create index if not exists idx_administradores_cancha_usuario on public.administradores_cancha(usuario_id);
create index if not exists idx_tarifas_cancha_dia on public.tarifas_cancha(cancha_id, dia_semana);
create index if not exists idx_reservas_cancha_fecha on public.reservas(cancha_id, fecha);
create index if not exists idx_reservas_usuario_fecha on public.reservas(usuario_id, fecha);
create index if not exists idx_reservas_estado on public.reservas(estado);
create index if not exists idx_pagos_reserva on public.pagos(reserva_id);
create index if not exists idx_partido_jugadores_usuario on public.partido_jugadores(usuario_id);
create index if not exists idx_auditoria_sede_fecha on public.auditoria(sede_id, creado_at desc);

create or replace function public.set_actualizado_at()
returns trigger language plpgsql set search_path = public as $$
begin new.actualizado_at = now(); return new; end;
$$;

do $$
declare tabla text;
begin
  foreach tabla in array array['profiles', 'organizaciones', 'sedes', 'canchas', 'reservas', 'partidos_sala', 'partido_jugadores'] loop
    execute format('drop trigger if exists set_%s_actualizado_at on public.%I', tabla, tabla);
    execute format('create trigger set_%s_actualizado_at before update on public.%I for each row execute function public.set_actualizado_at()', tabla, tabla);
  end loop;
end $$;

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, nombre, avatar_url)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'name', 'Jugador Nuevo'), new.raw_user_meta_data->>'avatar_url')
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute function public.handle_new_user();

-- Para asignar un administrador a una cancha mediante su correo:
-- 1. Crear su correo en Supabase Auth.
-- 2. Obtener el id del usuario autenticado.
-- 3. Obtener el id de la cancha.
-- 4. Insertarlo en administradores_cancha con rol Administrador u Operador.
-- El correo permanece gestionado por auth.users y no se duplica en public.
-- insert into public.administradores_cancha (cancha_id, usuario_id, rol)
-- values ('ID_DE_LA_CANCHA', 'ID_DEL_USUARIO_AUTH', 'Administrador');