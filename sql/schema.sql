-- DIGITAL CNC WOOD DESIGN HOUSE
-- Run this entire file in Supabase SQL Editor.

create extension if not exists pgcrypto;

create table if not exists public.business_info (
  id uuid primary key default gen_random_uuid(),
  business_name text not null default 'DIGITAL CNC WOOD DESIGN HOUSE',
  greeting text not null default 'আসসালামুয়ালাইকুম',
  welcome_text text not null default 'আপনার পছন্দের ডিজাইন, CNC কাটিং ও নিখুঁত হাতের ফিনিশিং—সব একসাথে।',
  tagline text not null default '2D • 2.5D • 3D CNC মেশিনের কাজ',
  finishing_text text not null default 'CNC কাটিং এর পর সম্পূর্ণ হাতের ফিনিশিং',
  owner text not null default 'প্রোঃ খলিলুর রহমান',
  phone1 text not null default '01881-246230',
  phone2 text not null default '01787-117759',
  whatsapp text default '8801881246230',
  imo text default '',
  address text not null default 'আমরাইদ বাজার, কাপাসিয়া রোড, পেট্রোল পাম্পের দক্ষিণ পাশে, স-মিল সংলগ্ন, কাপাসিয়া, গাজীপুর।',
  maps_url text default '',
  facebook_url text default '',
  website_url text default '',
  updated_at timestamptz not null default now()
);

create table if not exists public.services (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text default '',
  icon text default '✦',
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.gallery (
  id uuid primary key default gen_random_uuid(),
  title text not null default 'আমাদের কাজ',
  description text default '',
  image_url text not null,
  storage_path text not null,
  category text not null default 'অন্যান্য',
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

insert into public.business_info (id) values (gen_random_uuid()) on conflict do nothing;

insert into public.services (title, description, icon, sort_order)
select * from (values
 ('CNC দরজা ডিজাইন','আধুনিক ও ক্লাসিক ডিজাইনে CNC দরজা কাটিং ও ফিনিশিং।','🚪',1),
 ('CNC জালি','দরজা, পার্টিশন ও ফার্নিচারের জন্য নান্দনিক জালি ডিজাইন।','✦',2),
 ('খাট ও ফার্নিচার ডিজাইন','খাট, ক্যাবিনেট ও অন্যান্য কাঠের ফার্নিচারের কাস্টম CNC ডিজাইন।','🛏️',3),
 ('MDF CNC কাটিং','MDF ও উপযুক্ত বোর্ডে নির্ভুল CNC কাটিং।','▣',4),
 ('2D CNC ডিজাইন','নির্ভুল 2D প্যাটার্ন, প্যানেল ও ডেকোরেটিভ কাটিং।','2D',5),
 ('2.5D CNC ডিজাইন','গভীরতা ও লেয়ারের সুন্দর 2.5D ডিজাইন।','2.5D',6),
 ('3D CNC ডিজাইন','নকশা ও রিলিফসহ আকর্ষণীয় 3D CNC কাজ।','3D',7),
 ('কাস্টম ডিজাইন','আপনার ছবি/আইডিয়া অনুযায়ী কাস্টম CNC ডিজাইন।','✎',8),
 ('হাতের ফিনিশিং','CNC কাটিং এর পর সম্পূর্ণ হাতের ফিনিশিং।','✓',9),
 ('ডেকোরেটিভ কাঠের কাজ','বাড়ি, দোকান ও ফার্নিচারের জন্য ডেকোরেটিভ কাঠের ডিজাইন।','◆',10)
) as v(title,description,icon,sort_order)
where not exists (select 1 from public.services);

alter table public.business_info enable row level security;
alter table public.services enable row level security;
alter table public.gallery enable row level security;

create policy "public can read business info" on public.business_info for select using (true);
create policy "authenticated can update business info" on public.business_info for update to authenticated using (true) with check (true);
create policy "public can read services" on public.services for select using (true);
create policy "authenticated can insert services" on public.services for insert to authenticated with check (true);
create policy "authenticated can update services" on public.services for update to authenticated using (true) with check (true);
create policy "authenticated can delete services" on public.services for delete to authenticated using (true);
create policy "public can read gallery" on public.gallery for select using (true);
create policy "authenticated can insert gallery" on public.gallery for insert to authenticated with check (true);
create policy "authenticated can update gallery" on public.gallery for update to authenticated using (true) with check (true);
create policy "authenticated can delete gallery" on public.gallery for delete to authenticated using (true);

insert into storage.buckets (id, name, public) values ('gallery','gallery',true) on conflict (id) do nothing;

create policy "public can view gallery files" on storage.objects for select using (bucket_id = 'gallery');
create policy "authenticated can upload gallery files" on storage.objects for insert to authenticated with check (bucket_id = 'gallery');
create policy "authenticated can update gallery files" on storage.objects for update to authenticated using (bucket_id = 'gallery') with check (bucket_id = 'gallery');
create policy "authenticated can delete gallery files" on storage.objects for delete to authenticated using (bucket_id = 'gallery');
