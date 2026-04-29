alter table public.product_settings
  add column if not exists layout_mode text not null default 'gallery',
  add column if not exists banner_image text;

alter table public.product_settings
  drop constraint if exists product_settings_layout_mode_check;

alter table public.product_settings
  add constraint product_settings_layout_mode_check
  check (layout_mode in ('gallery', 'banner'));
