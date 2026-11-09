# Inclusão Alimentar — V8: cadastro e aprovação real de parceiros

## O que ficou pronto

- Site institucional e links do Senado **preservados**.
- `cardapio/empresa.html`: cadastro/login via Supabase Auth, solicitação de parceria, exigência de opção inclusiva e acompanhamento do status.
- `cardapio/gestao.html`: login, conferência do privilégio de administrador no banco, lista de pedidos, análise, aprovação, recusa, suspensão e benefício (base/reduzido/isento).
- `cardapio/supabase-schema.sql`: tabelas, políticas RLS, função de aprovação autorizada e histórico de auditoria.
- O banco bloqueia alteração direta do estado da solicitação por uma empresa; não é só um botão escondido.

## IMPORTANTE — etapas obrigatórias antes de testar com dados reais

**Este ZIP não tem um banco criado nem configurações privadas.** Apenas subir no GitHub Pages NÃO ativa os cadastros. O sistema avisa quando não está configurado. É necessário realizar estes passos:

1. Crie um projeto gratuito no [Supabase](https://supabase.com/dashboard). Evite cadastrar informações reais até concluir testes de acesso.
2. Vá a **SQL Editor** e execute o conteúdo completo de `cardapio/supabase-schema.sql`.
3. Em **Authentication → URL Configuration**, configure **Site URL** como `https://elisabetemeirinho.github.io/inclusao-alimentar/cardapio/empresa.html`, e em **Redirect URLs** acrescente este mesmo endereço. Ative confirmação por e-mail e configure corretamente o envio para uso real.
4. Em **Project Settings → API Keys** ou **Connect**, copie apenas **Project URL** e **publishable key** (ou `anon` legada) para `cardapio/config.js` nas duas constantes indicadas. **NUNCA use `service_role`/secret key no site público.**
5. Suba o conteúdo deste ZIP ao GitHub respeitando suas pastas. Faça login em `cardapio/empresa.html` com sua conta pessoal e confirme o e-mail.
6. Para liberar **somente você** como administradora, execute no SQL Editor (substitua pelo seu próprio e-mail de conta confirmada):

```sql
insert into public.platform_admins(user_id)
select id from auth.users where email = 'SEU_EMAIL_DE_ADMIN_CONFIRMADO'
on conflict (user_id) do nothing;
```

7. Saia e entre em `cardapio/gestao.html`. Crie outra conta de teste em janela anônima para simular a empresa. Envie uma solicitação com dados **fictícios** e confirme que aparece em seu painel. Aprove e confira o status na conta da empresa. Teste também recusa e suspensão.

## Limitações desta versão

- **Não existe ainda gestão REAL de produtos, fotos e pedidos de empresas aprovadas.** A área anterior demonstrativa continua no cardápio público, claramente identificada como exemplo. A aprovação real é a primeira etapa isolada.
- **Não existe cobrança real:** `base`, `reduced` e `free` são registros de benefícios/planos propostos, não assinatura nem bloqueio automático de inadimplência.
- **Não há verificação automática de CNPJ, ingredientes ou contato cruzado.** A administração deve comprovar os critérios antes de aprovar. As declarações dos estabelecimentos não são certificações de segurança.
- **Não há e-mail automático de notificação de novas solicitações**, mas a fila fica registrada e visível no painel quando você entra.
- Uma conta só pode enviar uma solicitação nesta versão. Não há edição ou reenvio pelo restaurante; caberá aprimorar isso num próximo passo.
- Para receber dados pessoais verdadeiros, serão necessárias política de privacidade, retenção, processo de exclusão e revisão LGPD, além de validação operacional da solução.

## Por que não usar apenas localStorage?

O `localStorage` utilizado no protótipo antigo é isolado por navegador. Supabase Auth, PostgreSQL e políticas RLS trazem dados compartilhados e permissões de fato aplicadas no servidor.

## Estrutura

A raiz contém o site institucional. `cardapio` contém páginas e recursos do sistema. Os arquivos `empresa-demo-original.html.txt` e `gestao-demo-original.html.txt` são apenas backups de texto para consulta. O `app.js` do cardápio é mantido para a vitrine **demonstrativa**, não governa o cadastro real.
