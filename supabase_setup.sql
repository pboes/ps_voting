-- ── Votes table ───────────────────────────────────────────────────────────────
create table if not exists votes (
  id          bigint generated always as identity primary key,
  wallet      text        not null,
  rank1       text        not null,
  rank2       text        not null,
  rank3       text        not null,
  rank4       text        not null,
  signature   text        not null,
  verified    boolean     not null default false,
  created_at  timestamptz not null default now()
);

-- One vote per wallet (enforce at DB level, ready to activate)
-- Currently NOT enforced — remove the comment below when ready
-- alter table votes add constraint votes_wallet_unique unique (wallet);

-- ── Row Level Security ────────────────────────────────────────────────────────
alter table votes enable row level security;

-- Anyone (anon) can insert a vote
create policy "anon can insert"
  on votes for insert
  to anon
  with check (true);

-- Anyone can read all votes (for the results screen)
create policy "anon can select"
  on votes for select
  to anon
  using (true);

-- Nobody can update or delete via the API
-- (no policies created for update/delete = implicitly denied)