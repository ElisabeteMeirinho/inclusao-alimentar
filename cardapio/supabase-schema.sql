-- Execute no SQL Editor de um projeto Supabase NOVO (uma vez).
-- Esta migração cria dados reais, revisões auditáveis e autorização no servidor.
create extension if not exists pgcrypto;

create table if not exists public.platform_admins (
  user_id uuid primary key references auth.users(id) on delete cascade,
  granted_at timestamptz not null default now()
);
create table if not exists public.partner_applications (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null unique references auth.users(id) on delete cascade,
  business_name text not null check (char_length(trim(business_name)) between 2 and 120),
  cnpj text not null unique check (cnpj ~ '^[0-9]{14}$'),
  contact_name text not null check (char_length(trim(contact_name)) between 2 and 120),
  whatsapp text not null check (char_length(trim(whatsapp)) between 8 and 20),
  has_milk_free boolean not null default false,
  has_lactose_free boolean not null default false,
  has_gluten_free boolean not null default false,
  has_adaptation boolean not null default false,
  evidence text not null check (char_length(trim(evidence)) between 20 and 2000),
  status text not null default 'pending' check(status in ('pending','approved','rejected','suspended')),
  benefit text check(benefit in ('base','reduced','free')),
  admin_note text not null default '' check (char_length(admin_note)<=1000),
  reviewed_by uuid references auth.users(id),
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint some_inclusion check(has_milk_free or has_lactose_free or has_gluten_free or has_adaptation)
);
create table if not exists public.partner_review_audit (
  id bigint generated always as identity primary key,
  application_id uuid not null references public.partner_applications(id) on delete cascade,
  reviewer_id uuid not null references auth.users(id),
  previous_status text not null,
  new_status text not null,
  previous_benefit text,
  new_benefit text,
  note text not null default '',
  created_at timestamptz not null default now()
);

alter table public.platform_admins enable row level security;
alter table public.partner_applications enable row level security;
alter table public.partner_review_audit enable row level security;
revoke all on public.platform_admins from anon,authenticated;
revoke all on public.partner_applications from anon,authenticated;
revoke all on public.partner_review_audit from anon,authenticated;
grant select,insert on public.partner_applications to authenticated;
-- Não conceder UPDATE/DELETE às empresas (decisões só via função protegida)

create or replace function public.is_platform_admin()
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (select 1 from public.platform_admins a where a.user_id = (select auth.uid()));
$$;
revoke all on function public.is_platform_admin() from public,anon;
grant execute on function public.is_platform_admin() to authenticated;

-- Empresas veem apenas a própria solicitação; administradores veem todas.
create policy "owners read own application" on public.partner_applications
  for select to authenticated using (owner_id = (select auth.uid()));
create policy "admins read all applications" on public.partner_applications
  for select to authenticated using ((select public.is_platform_admin()));
-- Só é permitido enviar nova solicitação PENDENTE e sem decisão ou benefício.
create policy "owners create pending application" on public.partner_applications
  for insert to authenticated with check (
    owner_id = (select auth.uid()) and status='pending' and benefit is null
    and reviewed_by is null and reviewed_at is null and admin_note=''
  );
-- Nenhuma política permite alterar ou excluir solicitações pelo cliente.

create or replace function public.review_partner_application(
 p_application_id uuid,p_status text,p_benefit text,p_admin_note text)
returns void language plpgsql security definer set search_path = '' as $$
declare old_row public.partner_applications%rowtype;
begin
 if not public.is_platform_admin() then raise exception 'Acesso negado'; end if;
 if p_status not in ('pending','approved','rejected','suspended') then raise exception 'Status inválido'; end if;
 if p_benefit not in ('base','reduced','free') then raise exception 'Benefício inválido'; end if;
 if length(coalesce(p_admin_note,'')) > 1000 then raise exception 'Nota muito longa'; end if;
 select * into old_row from public.partner_applications where id=p_application_id for update;
 if not found then raise exception 'Solicitação inexistente'; end if;
 update public.partner_applications set status=p_status,
 benefit=case when p_status='approved' then p_benefit else null end,
 admin_note=coalesce(p_admin_note,''), reviewed_by=auth.uid(),reviewed_at=now(),updated_at=now()
 where id=p_application_id;
 insert into public.partner_review_audit(application_id,reviewer_id,previous_status,new_status,previous_benefit,new_benefit,note)
 values(p_application_id,auth.uid(),old_row.status,p_status,old_row.benefit,
 case when p_status='approved' then p_benefit else null end,coalesce(p_admin_note,''));
end;
$$;
revoke all on function public.review_partner_application(uuid,text,text,text) from public,anon;
grant execute on function public.review_partner_application(uuid,text,text,text) to authenticated;

-- Logs só visíveis à administradora; nenhuma alteração direta via API.
create policy "admins read review audit" on public.partner_review_audit
 for select to authenticated using ((select public.is_platform_admin()));
grant select on public.partner_review_audit to authenticated;
-- Nenhum GRANT em platform_admins ao navegador. Promova a sua conta SOMENTE pelo SQL Editor.

-- Após CRIAR e CONFIRMAR sua conta no site, execute manualmente no SQL Editor:
-- insert into public.platform_admins(user_id)
-- select id from auth.users where email = 'SEU_EMAIL_DE_ADMIN_CONFIRMADO'
-- on conflict (user_id) do nothing;
