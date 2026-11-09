# Inclusao Alimentar — V9 Firebase | configuracao inicial

**Esta versao esta preparada, mas NAO funciona antes de configurar seu proprio Firebase.** Nenhum projeto, banco ou administrador foi criado automaticamente. Nao use empresas reais antes de validar as regras e preparar politica de privacidade/LGPD.

## 1. Criar o projeto certo

Acesse https://console.firebase.google.com/ com a MESMA CONTA GOOGLE que ja usa no Ouvir & Ler. Crie um NOVO projeto Firebase chamado `inclusao-alimentar` — separado do banco do Ouvir & Ler, mas na mesma conta e console. Isso evita misturar dados e regras.

## 2. Ativar login

Firebase Console > Build > Authentication > Get started > Sign-in method > Email/Password > Enable. Em Authentication > Settings > Authorized domains, verifique `elisabetemeirinho.github.io` (adicione se necessario). O sistema envia e-mail de verificacao; a conta deve ser confirmada antes de enviar a solicitacao.

## 3. Criar o Firestore e publicar as regras

Build > Firestore Database > Create database. Escolha a regiao adequada e comece com **modo de producao** (acesso negado por padrao). Na aba **Rules**, substitua todo o conteudo pelo arquivo `cardapio/firestore.rules`, clique Publish. **IMPORTANTE**: publicar regras sobrescreve as regras do banco daquele projeto. Por isso usamos um projeto Firebase separado.

## 4. Registrar o site web e copiar configuracao publica

Project settings (engrenagem) > General > Your apps > Add app > Web. Registre o app (nao precisa habilitar Firebase Hosting). Copie `apiKey`, `authDomain`, `projectId` e `appId` para `cardapio/config.js`, substituindo `PREENCHA_...`. Estes quatro valores sao publicos por design, mas **NUNCA** adicione conta de servico, `private_key` ou arquivo administrativo no GitHub.

## 5. Publicar os arquivos no GitHub

Envie os arquivos deste ZIP respeitando a estrutura das pastas, com `index.html`, `styles.css`, `script.js` e `assets` na raiz, e `firebase-parcerias.js`, `config.js`, `firestore.rules`, `empresa.html`, `gestao.html` etc. DENTRO de `cardapio/`.

Abra https://elisabetemeirinho.github.io/inclusao-alimentar/cardapio/empresa.html . Crie a **sua** conta com e-mail e senha, confirme o e-mail, e faca login novamente. No Firebase Console > Authentication > Users, clique na conta e COPIE o **UID** (nao a senha).

## 6. Conceder acesso de administradora (UMA UNICA VEZ)

Firebase Console > Firestore Database > Data > Start collection:

- Collection ID: `platformAdmins`
- Document ID: **UID da sua conta, exatamente como em Authentication**
- Campo: `enabled` | tipo boolean | valor `true`

Salve. **Nunca crie admin atraves do formulario publico, nem publique regras temporarias como `allow read, write: if true`.** O console utiliza suas credenciais de proprietaria para criar esse documento; visitantes nao podem editar a colecao.

Acesse https://elisabetemeirinho.github.io/inclusao-alimentar/cardapio/gestao.html e entre com sua conta. O painel deve mostrar a lista das solicitacoes.

## 7. Teste de duas contas — com dados ficticios

1. Use uma janela anonima e outro e-mail seu de teste; crie uma conta em `empresa.html` e confirme o e-mail.
2. Envie uma solicitacao de restaurante ficticio (CNPJ de 14 digitos apenas para testes internos, nunca de terceiros).
3. Abra `gestao.html` na sua conta administradora: a solicitacao deve aparecer na lista.
4. Aprove e marque base/reduzido/isento. O painel grava a decisao no documento e um evento em `partnerAudit` (historico de demonstracao).
5. Atualize `empresa.html` com a conta do restaurante: ela deve ver `Aprovada` e o plano registrado.
6. Teste recusa e suspensao.
7. Tente acessar a gestao com a conta de restaurante: deve ser bloqueada pelas regras do banco, nao apenas pelo HTML.

## O que NAO esta pronto

- Cadastro efetivo de produtos, fotos, pedidos e cardapio da empresa aprovada. As paginas `cardapio/index.html`, `loja.html` e `app.js` seguem como demonstracao local, separadas do cadastro real.
- Pagamentos, mensalidades recorrentes e suspensao automatica por inadimplencia. Os planos sao apenas classificacoes manuais sem cobranca.
- CNPJ ou preparo real verificado, notificacoes por e-mail da plataforma e monitoramento automatico de declaracoes falsas.
- Auditoria resistente a administradores do proprio projeto (o console e proprietarios do projeto podem modificar documentos), politica LGPD e validacao externa de seguranca.

Antes de convidar restaurantes reais, definir politica de privacidade, retencao de dados, comprovacao da seguranca alimentar, testes das regras no Firebase Emulator e fluxo completo de produtos/pagamentos. A verificacao de e-mail nao substitui a verificacao da empresa.

**Importante**: a colecao `partnerApplications` tem um documento por UID. O restaurante envia uma solicitacao e nao pode altera-la nesta V9. A conta administradora pode mudar apenas situacao, beneficio e observacoes. O registro administrativo e o evento no historico sao enviados na mesma operacao em lote.
