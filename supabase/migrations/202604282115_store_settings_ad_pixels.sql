alter table public.store_settings
  add column if not exists facebook_pixel_id text,
  add column if not exists tiktok_pixel_id text,
  add column if not exists snapchat_pixel_id text,
  add column if not exists google_ads_id text,
  add column if not exists google_ads_conversion_label text;
