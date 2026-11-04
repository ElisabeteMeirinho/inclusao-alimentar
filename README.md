# Inclusão Alimentar — Cardápio Inclusivo (MVP demonstrativo)

Protótipo estático de cardápio digital inspirado nos fluxos gerais de cardápios web de delivery, **não cópia das marcas ou interfaces de terceiros**.

## Teste local

Abra `index.html` em seu navegador. Clique em **Painel do estabelecimento** e preencha o número do WhatsApp da loja no formato `55 + DDD + número` para habilitar o botão de envio via WhatsApp no checkout.

Configure taxas de entrega por bairro e cadastre pratos. No **Cardápio do cliente**, filtre por alergênicos, monte um carrinho, selecione entrega ou retirada e preencha dados do pedido.

## O que funciona

- Cardápio responsivo e filtros por alergênicos declarados.
- Cadastro/edição/exclusão de pratos no navegador.
- Preços, carrinho, taxa configurável por bairro, total e retirada grátis.
- Criação e acompanhamento de pedidos **no mesmo navegador** via `localStorage`, inclusive em abas diferentes no mesmo domínio.
- Aviso sonoro entre abas abertas no navegador, sujeito a permissões e limitações do browser.
- Botão **Enviar pelo WhatsApp**, que prepara mensagem para o número cadastrado. **O cliente precisa confirmar o envio no WhatsApp**; sem isso o estabelecimento não recebe nada.

## Limitações importantes

**Este é um protótipo, não uma operação de delivery pronta para restaurantes reais.** Dados são armazenados localmente por navegador; diferentes dispositivos não compartilham pedidos, e não existe servidor, controle de acesso, login, backup, emissão fiscal, pagamento online ou notificação remota automática. Publicar o HTML no GitHub Pages não corrige essas limitações. Não use dados reais de clientes nesta demonstração.

Taxas são por bairro, não por distância geográfica. Não há geocodificação nem cálculo de rota. Produtos e preços são fictícios.

Alergênicos são declarados pelo estabelecimento e dependem de conferência humana, incluindo ingredientes compostos, substituições e contato cruzado. Nenhum filtro, selo ou texto do protótipo representa garantia de segurança para pessoas com alergias ou doença celíaca.

Para produção, implementar: backend e banco com isolamento por estabelecimento, autenticação robusta, regras de acesso no servidor, checkout transacional, notificações remotas com fila/retry, controles antifraude/spam, backups, logs, política de privacidade e segurança para LGPD, além de validação das regras de alergênicos por especialistas.

## Publicação de teste

Pode hospedar os arquivos estáticos em GitHub Pages, Netlify ou similar **somente para demonstração**. Recomendo repositório separado do site institucional `inclusao-alimentar`.
