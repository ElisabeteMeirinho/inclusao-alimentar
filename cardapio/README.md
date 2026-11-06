# Inclusão Alimentar — v7 · Cadastro primeiro, produtos somente após aprovação

## O que mudou
- O portal começa **sem empresas cadastradas nem produtos**. Não existem restaurantes fictícios previamente aprovados para edição.
- Nova solicitação exige nome do estabelecimento, responsável, e-mail e pelo menos uma opção alimentar declarada ou adaptação viável.
- A empresa fica com status **Aguardando avaliação**. Enquanto estiver pendente, os formulários de produtos, ingredientes, fotos, bairros e configurações **não aparecem**.
- Em `gestao.html`, você seleciona a empresa e registra uma decisão justificada. Somente **Aprovada + Em dia** ou **Aprovada + Parceiro gratuito/isento** libera o editor.
- Antes disso, os botões de visualizar/copiar cardápio não são exibidos.
- Assim que a empresa é aprovada, o editor é exibido e os pratos podem ser cadastrados.
- A plataforma mantém demonstrações de ingredientes/alergênicos, adicionais e monitoramento no navegador.

## Como testar
1. Abra `empresa.html`. Não deve existir nenhum produto nem formulário de prato.
2. Cadastre um restaurante de teste com responsável, e-mail e alguma alternativa/adaptação. A solicitação deverá ficar pendente.
3. Abra `gestao.html` **no mesmo navegador**, encontre o pedido, registre justificativa, situação Aprovada e pagamento Em dia ou isenção, e salve a decisão.
4. Volte a `empresa.html` e atualize; o cadastro de produtos aparecerá.
5. Se a gestão mudar o status para Em análise ou Suspensa, o editor desaparece novamente.

## AVISO: demonstração, não controle de acesso real
Não há autenticação, banco de dados compartilhado, cobrança nem auditoria segura. `gestao.html` é publicamente acessível e o bloqueio pode ser burlado por alguém com conhecimentos técnicos. NÃO cadastre empresas nem dados pessoais reais. Antes do lançamento com parceiros de verdade, precisamos implementar login, autorização de servidor por empresa e administrador, armazenamento, cobrança por webhook validado e revisão LGPD.

## Publicar sem danificar o site institucional
Este ZIP contém **somente `cardapio/`**. Entre nessa pasta no repositório GitHub da branch `main` e envie os seis arquivos de dentro dela (`index.html`, `empresa.html`, `loja.html`, `gestao.html`, `styles.css`, `app.js`). **NÃO** envie `index.html` ou `styles.css` para a raiz `inclusao-alimentar/`.

A versão 7 usa a chave `ia-parceiros-v7` no armazenamento local para que empresas fictícias aprovadas em testes anteriores não apareçam indevidamente. Isso inicia uma nova demonstração; os dados de versões antigas não são migrados.
