create table if not exists public.pink_desk (
 user_id uuid primary key references auth.users(id) on delete cascade,
 data jsonb not null,
 version bigint not null default 1
);
alter table public.pink_desk enable row level security;
revoke all on public.pink_desk from anon;
grant select, insert, update on public.pink_desk to authenticated;
drop policy if exists own_desk on public.pink_desk;
create policy own_desk on public.pink_desk for all to authenticated
 using ((select auth.uid()) = user_id)
 with check ((select auth.uid()) = user_id);
