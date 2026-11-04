# Inclusão Alimentar — v6 · Solicitação, aprovação e acompanhamento

**Protótipo local demonstrativo**, sem autenticação nem banco de dados. Não permite operar empresas reais ou cobrar mensalidades.

## Fluxo demonstrativo

1. Abra `cardapio/empresa.html`. No bloco de solicitação, informe o nome, contato e ao menos uma alternativa alimentar **ou adaptação responsável**. Sem as duas possibilidades, o sistema apresenta uma mensagem acolhedora e não permite concluir.
2. A empresa nova entra como **Pendente**, e o editor de produtos fica **oculto**. A análise de até 5 dias úteis é uma meta futura, não um atendimento automático.
3. Abra `cardapio/gestao.html`. Filtre pendentes, registre justificativa, situação, modalidade financeira e estado da cobrança. Para liberar o editor, aprove e marque pagamento **Em dia**, ou selecione **Parceiro gratuito / isento**.
4. Volte à área da empresa e selecione a empresa aprovada. Agora ela pode cadastrar produtos, ingredientes individualizados, foto, adicionais, taxas e WhatsApp; o cliente vê só os dados do restaurante escolhido.
5. A gestão registra um histórico local: solicitações, decisões justificadas, alterações de pratos e taxas, remoções, alertas e revisões. Os critérios Premium são propostos se as três opções forem declaradas, mas não equivalem à certificação.
6. O estado de cobrança pode ser simulado manualmente: Em dia, aviso, restrito, suspenso. Gratuitos não são bloqueados por falta de pagamento. Não há cobrança real, vencimento automático nem notificações externas.

## AVISO DE SEGURANÇA

O GitHub Pages serve arquivos públicos. **Não há login, permissões de acesso, dados compartilhados entre dispositivos ou auditoria inviolável.** Pessoas que abrirem `gestao.html` podem operar a demonstração em seus próprios navegadores. Não cadastre dados reais. Para produção é indispensável backend com autenticação (empresa e administração), permissões por empresa no banco, armazenamento de fotos, logs server-side imutáveis para empresas, webhooks verificados do provedor de pagamento e revisão de segurança/privacidade (LGPD).

Sem leite/proteínas do leite **não** significa sem lactose. Ausência declarada de glúten na receita não garante adequação para celíacos. Retirar um ingrediente não garante ausência do alergênico por contato cruzado. Uma opção Premium precisa de documentação e validação humana, nunca apenas uma checkbox.

## Publicação sem quebrar o site institucional

O ZIP contém somente a pasta `cardapio/`. No repositório `ElisabeteMeirinho/inclusao-alimentar`, na branch `main`, clique **dentro da pasta `cardapio`** antes de fazer Add file > Upload files. Suba somente os seis arquivos listados: `index.html`, `loja.html`, `empresa.html`, `gestao.html`, `styles.css` e `app.js`. Não envie os arquivos à raiz e não altere `/index.html`, `/styles.css` ou `/script.js` do site institucional. Faça backup antes da atualização.
