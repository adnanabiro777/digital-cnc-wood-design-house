# DIGITAL CNC WOOD DESIGN HOUSE — Final Deploy Package

## কী আছে
- Public Bengali business website: `index.html`
- Bengali Admin Panel: `admin/index.html`
- Supabase database/storage schema: `sql/schema.sql`
- QR generator: `qr.html`
- Supabase config: `config.js`

## একবারের online setup
1. Supabase-এ project তৈরি করুন।
2. SQL Editor-এ `sql/schema.sql` পুরোটা Run করুন।
3. Authentication > Users-এ admin email/password তৈরি করুন।
4. Project Settings > API থেকে Project URL এবং anon public key নিন।
5. root `config.js` এবং `admin/config.js`-এ একই URL/key বসান।
6. পুরো folder-এর contents GitHub Pages / Netlify / Vercel-এর মতো static hosting-এ publish করুন।
7. Public URL খুলে website দেখুন।
8. `/admin/` খুলে admin email/password দিয়ে login করুন।
9. Public URL `qr.html`-এ দিয়ে QR তৈরি করুন।

## নিরাপত্তা
- `anon public key` browser-এ থাকা স্বাভাবিক।
- `service_role` key কখনও website/admin files-এ রাখবেন না।
- Admin password/OTP কাউকে দেবেন না।
- এই schema-তে database/storage write operations authenticated users-এর জন্য সীমাবদ্ধ।

## পরে আপনি কী করবেন
Admin Panel > ব্যবসার তথ্য / সেবা / গ্যালারি।
সেখান থেকে ছবি যোগ/মুছুন এবং তথ্য পরিবর্তন করুন। Public Page ও QR URL একই থাকবে।
