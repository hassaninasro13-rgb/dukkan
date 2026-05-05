-- Run in Supabase SQL Editor: adds store card thumbnail column for merchant_products
alter table public.merchant_products
  add column if not exists thumbnail_image text;

comment on column public.merchant_products.thumbnail_image is 'Square/short thumbnail URL for store listing cards; separate from images gallery';
