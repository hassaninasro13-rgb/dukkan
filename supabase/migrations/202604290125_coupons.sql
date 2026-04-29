create extension if not exists pgcrypto;

create table if not exists public.coupons (
  id uuid primary key default gen_random_uuid(),
  merchant_id uuid not null references public.merchants(id) on delete cascade,
  code text not null,
  discount_type text not null check (discount_type in ('percent','fixed')),
  discount_value numeric not null check (discount_value > 0),
  min_order numeric,
  max_uses integer,
  uses_count integer not null default 0,
  expires_at timestamptz,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (merchant_id, code)
);

create index if not exists coupons_merchant_id_idx
  on public.coupons (merchant_id);

create index if not exists coupons_lookup_idx
  on public.coupons (merchant_id, code)
  where is_active = true;

alter table public.orders
  add column if not exists coupon_code text,
  add column if not exists discount_amount numeric default 0;

grant select, insert, update, delete on public.coupons to anon;
