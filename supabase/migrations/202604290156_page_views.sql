create extension if not exists pgcrypto;

create table if not exists public.page_views (
  id uuid primary key default gen_random_uuid(),
  merchant_id uuid not null references public.merchants(id) on delete cascade,
  product_id uuid references public.merchant_products(id) on delete set null,
  device text not null default 'desktop' check (device in ('mobile','desktop')),
  viewed_at timestamptz not null default now()
);

create index if not exists page_views_merchant_viewed_at_idx
  on public.page_views (merchant_id, viewed_at desc);

create index if not exists page_views_product_id_idx
  on public.page_views (product_id);

grant select, insert on public.page_views to anon;
