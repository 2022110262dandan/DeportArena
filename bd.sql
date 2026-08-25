-- Habilitar extensión para IDs robustos (UUIDs)
create extension if not exists "pgcrypto";

-- Enums para la lógica de juego y negocio
create type posicion_futbol as enum ('Portero', 'Defensa', 'Centrocampista', 'Delantero');
create type estado_asistencia as enum ('Confirmado', 'Pendiente', 'Rechazado');
create type tipo_cancha as enum ('5v5', '7v7', '11v11');
create type metodo_pago as enum ('Efectivo', 'Tarjeta', 'Transferencia', 'Online');
create type estado_pago as enum ('Pendiente', 'Parcial', 'Pagado');


create table public.profiles (
  id uuid references auth.users on delete cascade primary key,
  nombre text not null,
  avatar_url text,
  posiciones_preferidas posicion_futbol[] default '{}',
  es_administrador boolean default false,
  creado_at timestamp with time zone default timezone('utc'::text, now()) not null
);

create table public.canchas (
  id uuid default gen_random_uuid() primary key,
  nombre text not null, -- Ej. "Cancha 1 - Maracaná"
  tipo tipo_cancha not null,
  superficie text default 'Césped Sintético' not null,
  max_jugadores integer not null,
  esta_techada boolean default false,
  esta_activa boolean default true,
  creado_at timestamp with time zone default timezone('utc'::text, now()) not null
);

create table public.tarifas_cancha (
  id uuid default gen_random_uuid() primary key,
  cancha_id uuid references public.canchas(id) on delete cascade not null,
  dia_semana integer not null, -- 0 (Domingo) a 6 (Sábado)
  hora_inicio time not null,   -- Ej. '18:00:00'
  hora_fin time not null,      -- Ej. '23:00:00'
  precio_por_hora numeric(10, 2) not null,
  nombre_tarifa text           -- Ej. "Horario Prime"
);

create table public.reservas (
  id uuid default gen_random_uuid() primary key,
  cancha_id uuid references public.canchas(id) on delete cascade not null,
  usuario_id uuid references public.profiles(id) on delete set null, -- NULL si es bloqueo del admin
  fecha date not null,
  hora_inicio time not null,
  hora_fin time not null,
  es_bloqueo_admin boolean default false,
  motivo_bloqueo text, -- Ej. "Mantenimiento de luminarias" o "Reserva Telefónica"
  precio_total numeric(10, 2) not null,
  monto_pagado numeric(10, 2) default 0.00,
  estado_pago estado_pago default 'Pendiente' not null,
  metodo_pago_final metodo_pago,
  check_in_realizado boolean default false,
  enlace_invitacion_token uuid default gen_random_uuid() unique,
  creado_at timestamp with time zone default timezone('utc'::text, now()) not null
);

create table public.partidos_sala (
  id uuid default gen_random_uuid() primary key,
  reserva_id uuid references public.reservas(id) on delete cascade not null,
  capitan_id uuid references public.profiles(id) on delete set null,
  equipos_bloqueados boolean default false,
  -- Guardamos la estructura del Drag & Drop como JSONB para máxima flexibilidad al mover las tarjetas
  equipo_a jsonb default '[]'::jsonb, 
  equipo_b jsonb default '[]'::jsonb,
  creado_at timestamp with time zone default timezone('utc'::text, now()) not null
);  

create table public.partido_jugadores (
  id uuid default gen_random_uuid() primary key,
  partido_id uuid references public.partidos_sala(id) on delete cascade not null,
  usuario_id uuid references public.profiles(id) on delete cascade not null,
  posicion_elegida posicion_futbol not null,
  estado estado_asistencia default 'Pendiente' not null,
  creado_at timestamp with time zone default timezone('utc'::text, now()) not null,
  unique (partido_id, usuario_id) -- Evita que un jugador se una dos veces al mismo partido
);  

-- 1. Crear la función que copia el usuario de auth a public
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, nombre, avatar_url)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'name', 'Jugador Nuevo'),
    new.raw_user_meta_data->>'avatar_url'
  );
  return new;
end;
$$ language plpgsql security definer;

-- 2. Crear el trigger que se dispara al insertar en auth.users
create or replace trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();