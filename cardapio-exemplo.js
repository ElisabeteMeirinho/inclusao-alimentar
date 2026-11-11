// Exemplo educativo de filtros, sem pedidos reais ou comprovação de segurança.
(() => {
  'use strict';
  const panel = document.querySelector('.filter-panel');
  if (!panel) return;
  const inputs = [...panel.querySelectorAll('input[type="checkbox"]')];
  const cards = [...document.querySelectorAll('.example-card')];
  const summary = document.getElementById('filter-summary');
  const empty = document.getElementById('no-results');
  const normalize = value => (value || '').split(',').map(v => v.trim()).filter(Boolean);
  function update() {
    const selected = inputs.filter(i => i.checked).map(i => i.value);
    let shown = 0;
    for (const card of cards) {
      const contains = normalize(card.dataset.contains);
      const uncertain = normalize(card.dataset.uncertain);
      // Não marcar como elegível um produto que contenha ou não tenha
      // declaração conclusiva sobre o ingrediente selecionado.
      const compatible = selected.every(allergen => !contains.includes(allergen) && !uncertain.includes(allergen));
      card.hidden = !compatible;
      if (compatible) shown++;
    }
    summary.textContent = selected.length
      ? `${shown} de ${cards.length} exemplos sem os ingredientes selecionados na receita declarada. Confirme o preparo e o contato cruzado.`
      : `Exibindo ${shown} pratos ilustrativos. Selecione uma restrição para filtrar.`;
    empty.hidden = shown !== 0;
  }
  inputs.forEach(i => i.addEventListener('change',update));
  document.getElementById('clear-filters')?.addEventListener('click',() => {inputs.forEach(i => {i.checked=false});update()});
  update();
})();
