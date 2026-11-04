# Inclusão Alimentar — Cardápios multiempresa v3 (DEMONSTRAÇÃO)

## O que mudou
- Diretório de estabelecimentos fictícios (página inicial de `cardapio/`).
- Cada empresa tem cardápio, produtos, fotos, taxas e WhatsApp independentes, separados **no armazenamento deste navegador**.
- URL de cada empresa: `.../cardapio/?empresa=pizzaria-exemplo#menu`.
- Painel de demonstração permite escolher ou criar empresa, cadastrar pratos com fotografias, informar ingredientes e alergênicos e configurar taxas e WhatsApp.
- Carrinho e mensagem de WhatsApp usam o estabelecimento atualmente aberto. O cliente confirma o envio no WhatsApp.

## ATENÇÃO: NÃO É SISTEMA MULTIEMPRESA DE PRODUÇÃO
Os dados são guardados somente no `localStorage` de cada navegador. O link individual de uma empresa criada pelo usuário não compartilha suas informações com outros celulares. Qualquer visitante consegue abrir o painel demonstrativo. Não utilize com clientes reais, dados pessoais reais ou pedidos comerciais.

Para disponibilizar empresas reais com links compartilháveis, é necessário backend/banco de dados (ex.: Supabase), login e isolamento de permissões entre empresas, storage para fotos, controles de segurança, privacidade e regras de alergênicos. Pedidos entre dispositivos e notificações não existem nesta versão.

## Como publicar SEM alterar o site institucional
No GitHub, entre em `inclusao-alimentar/cardapio/` na branch `main` e envie `index.html`, `styles.css` e `app.js` deste pacote. Substitua só esses três arquivos. A raiz do repositório (`/index.html` e `/styles.css`) pertence ao site institucional, não substitua.

Opcional: a capa visual depende da imagem `cardapio/assets/mesa-compartilhada.webp`. Se ela não existir, envie a imagem incluída neste ZIP para aquela subpasta (ou use a foto institucional de acordo com as licenças aplicáveis).

Abra `https://elisabetemeirinho.github.io/inclusao-alimentar/cardapio/` após o deploy do GitHub Pages.
