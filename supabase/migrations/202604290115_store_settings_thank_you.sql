alter table public.store_settings
  add column if not exists thankyou_title text,
  add column if not exists thankyou_message text,
  add column if not exists thankyou_whatsapp_enabled boolean default true,
  add column if not exists thankyou_whatsapp_message text;
