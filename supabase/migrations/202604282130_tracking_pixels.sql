create extension if not exists pgcrypto;

create table if not exists public.tracking_pixels (
  id uuid primary key default gen_random_uuid(),
  merchant_id uuid not null references public.merchants(id) on delete cascade,
  platform text not null check (platform in ('facebook','tiktok','snapchat','google')),
  pixel_id text not null,
  conversion_label text,
  label text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists tracking_pixels_merchant_id_idx
  on public.tracking_pixels (merchant_id);

create index if not exists tracking_pixels_active_platform_idx
  on public.tracking_pixels (merchant_id, platform)
  where is_active = true;

grant select, insert, update, delete on public.tracking_pixels to anon;
