alter table public.merchant_products
  alter column images type text using images::text;
