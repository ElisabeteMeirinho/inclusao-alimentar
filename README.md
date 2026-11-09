# Inclusão Alimentar — site institucional e cardápio demonstrativo

## Publicação no GitHub Pages

Envie o **conteúdo** deste ZIP para a raiz do repositório `inclusao-alimentar` na branch `main`, mantendo a pasta `cardapio/` separada e a pasta `assets/`.

- `index.html`: site institucional
- `cardapio/index.html`: vitrine demonstrativa de restaurantes
- `cardapio/empresa.html`: portal demonstrativo de empresas
- `cardapio/gestao.html`: gestão demonstrativa da plataforma

## Propostas oficiais no Senado Federal

- Segurança Alimentar — https://www12.senado.leg.br/ecidadania/visualizacaoideia?id=252857
- Inclusão Alimentar — https://www12.senado.leg.br/ecidadania/visualizacaoideia?id=252859

Os números de apoio e o andamento das ideias devem ser consultados diretamente no Senado; não são atualizados automaticamente neste site.

## Importante sobre o cardápio

A pasta `cardapio/` contém um protótipo **demonstrativo**, não uma plataforma operacional. Os dados são salvos localmente no navegador. O bloqueio visual do cadastro de produtos antes da aprovação não é controle de acesso seguro: para empresas reais, é necessário backend com autenticação, permissões verificadas no servidor, banco de dados, armazenamento e conformidade com a LGPD. Não use dados de empresas ou clientes reais neste protótipo.


## Firebase (V9)
O cadastro e a aprovacao de empresas usam Firebase Authentication e Firestore. Configure como descrito em `INSTRUCOES-FIREBASE.md`. Nao esta ativo apenas por publicar no GitHub Pages.
