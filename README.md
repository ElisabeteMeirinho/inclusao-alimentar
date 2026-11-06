# Inclusão Alimentar — Cardápios de parceiros (v4)

## O que mudou

- `index.html`: vitrine de empresas, sem misturar pratos.
- `loja.html?empresa=cozinha-da-mesa`: página exclusiva de um restaurante, apenas para clientes, sem acesso administrativo no menu. Cada empresa tem produtos, frete por bairro e WhatsApp próprios.
- `empresa.html`: área demonstrativa para registrar empresas, produtos com fotos, ingredientes, alergênicos e informações de contato cruzado; solicitar avaliação para parceria e cadastrar entrega.
- `gestao.html`: área demonstrativa de administração da plataforma, com aprovação de parcerias e aplicação manual de valores de exemplo ou isenção.

## Publicação no GitHub

1. Acesse a pasta `/cardapio` da branch `main` no repositório `inclusao-alimentar`.
2. Faça upload dos **seis arquivos** desta pasta: `index.html`, `loja.html`, `empresa.html`, `gestao.html`, `styles.css`, `app.js`.
3. Confira se os novos arquivos aparecem em `/cardapio`, não na raiz, e confirme o commit.
4. A página inicial continua `.../inclusao-alimentar/cardapio/`. Links específicos como `.../cardapio/loja.html?empresa=pizzaria-exemplo`.
5. Não faça merge da PR antiga da branch `cardapio` se ela substitui o site institucional.

## Limites técnicos — MUITO IMPORTANTE

Este é um **protótipo local**, não um SaaS pronto para uso real. Todos os dados ficam somente em `localStorage` do navegador e os três restaurantes iniciais são fictícios. Perfis `empresa.html` e `gestao.html` são APENAS telas demonstrativas: **não têm autenticação, autorização, isolamento seguro ou privacidade**, e qualquer pessoa com o link poderia visitá-las. A interface da loja não mostra os controles administrativos, mas isso não é proteção.

**Não cadastre dados de clientes, empresas reais nem divulgue o link administrativo para uso operacional.** Uma empresa cadastrada no seu navegador não aparecerá em outros aparelhos; fotos locais também não. Para o uso real, a próxima etapa indispensável é implementar backend com autenticação, papéis (cliente público / proprietário da empresa / administrador), Row Level Security no banco, armazenamento de fotos, auditoria e privacidade LGPD. O GitHub Pages hospeda apenas o frontend estático.

## Pedidos por WhatsApp

O pedido gera uma mensagem e abre o WhatsApp informado pela empresa. O cliente ainda precisa confirmar o envio no WhatsApp. Não há pedido automático nem painel em tempo real. Número de WhatsApp dos exemplos começa vazio de propósito.

## Parceria e mensalidade

Critérios e preços estão ilustrativos, **não são regras comerciais já definidas**. A administração revisa manualmente as condições antes de aprovar/descontar/isentar. Distinguimos *sem leite*, *sem lactose*, *sem glúten* e necessidades de celíacos e alérgicos. Não use a ausência de uma declaração de alergênico como prova de segurança; informações alimentares dependem da responsabilidade do fornecedor, controle de preparo e contato cruzado.
<!-- Solicitação de nova publicação do GitHub Pages -->
