alter table public.store_settings
  add column if not exists google_sheets_webhook text;
