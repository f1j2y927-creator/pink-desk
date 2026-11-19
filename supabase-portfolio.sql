-- Run once in Supabase SQL Editor. Private portfolio bucket.
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('pink-portfolio','pink-portfolio',false,10485760,
 array['image/png','image/jpeg','image/webp','image/gif','application/pdf'])
on conflict (id) do nothing;
drop policy if exists "pink portfolio own read" on storage.objects;
create policy "pink portfolio own read" on storage.objects for select to authenticated
using (bucket_id='pink-portfolio' and (storage.foldername(name))[1]=(select auth.uid())::text);
drop policy if exists "pink portfolio own insert" on storage.objects;
create policy "pink portfolio own insert" on storage.objects for insert to authenticated
with check (bucket_id='pink-portfolio' and (storage.foldername(name))[1]=(select auth.uid())::text);
