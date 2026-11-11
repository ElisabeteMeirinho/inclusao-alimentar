(() => {
  const url = String(window.PLATAFORMA_CARDAPIO_URL || '').trim();
  const link = document.getElementById('partner-platform-link');
  const status = document.getElementById('partner-platform-status');
  if (!link || !status) return;
  try {
    const parsed = new URL(url);
    if (parsed.protocol === 'https:' || parsed.protocol === 'http:') {
      link.href = parsed.href;
      link.hidden = false;
      status.hidden = true;
    }
  } catch (_) { /* Mantém o aviso de implantação enquanto não houver URL pública. */ }
})();
