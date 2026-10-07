-- Tabulka pro názory a nápady z Generátoru výmluv.
-- Vlož celý tento text do Supabase: SQL Editor → New query → Run.

create table if not exists public.nazory (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  jmeno text check (char_length(jmeno) <= 40),
  nalada text check (nalada in ('😂', '🙂', '😐', '💡')),
  zprava text not null check (char_length(zprava) between 3 and 1000)
);

-- Kdokoli (i bez přihlášení) může názory číst a přidávat, ale nemůže je měnit ani mazat.
alter table public.nazory enable row level security;

create policy "Kdokoli muze cist" on public.nazory
  for select to anon using (true);

create policy "Kdokoli muze pridat" on public.nazory
  for insert to anon with check (true);

grant select, insert on public.nazory to anon;
grant usage on schema public to anon;
