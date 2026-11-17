// Carregamento resiliente da integração Firebase.
// Captura falhas de importação do SDK e impede a mensagem "Conectando..." infinita.
(() => {
  const status = document.getElementById('firebase-status');
  const setup = document.getElementById('setup');
  const authForms = document.getElementById('auth-forms');
  const adminLogin = document.getElementById('admin-login');
  const config = window.INCLUSAO_FIREBASE_CONFIG || {};
  const hasValue = (value) => {
    if (typeof value !== 'string') return false;
    const clean = value.trim();
    return clean.length > 0
      && !clean.startsWith('PREENCHA_')
      && !clean.startsWith('YOUR_')
      && !clean.includes('{{')
      && !clean.startsWith('<');
  };
  const configured = ['apiKey', 'authDomain', 'projectId', 'appId']
    .every((key) => hasValue(config[key]));

  const setStatus = (message, state = 'pending') => {
    if (!status) return;
    status.textContent = message;
    status.className = state === 'error'
      ? 'alert error'
      : state === 'ok'
        ? 'alert good'
        : 'muted';
    status.dataset.state = state;
  };

  if (!configured) {
    setup?.classList.remove('hidden');
    authForms?.classList.add('hidden');
    adminLogin?.classList.add('hidden');
    setStatus('A configuração do Firebase ainda está incompleta. Confira cardapio/config.js e as instruções de configuração.', 'error');
    return;
  }

  let settled = false;
  setStatus('Preparando a conexão com o Firebase…');
  const timeout = window.setTimeout(() => {
    if (settled) return;
    const message = navigator.onLine
      ? 'A conexão está demorando para responder. Confira sua internet e atualize a página. Se continuar, verifique a disponibilidade do Firebase.'
      : 'O navegador está sem conexão com a internet. Reconecte-se e atualize a página.';
    setStatus(message);
  }, 12000);

  window.addEventListener('inclusao:firebase-ready', () => {
    settled = true;
    window.clearTimeout(timeout);
  }, { once: true });

  window.addEventListener('offline', () => {
    if (!settled) setStatus('Sem conexão com a internet. Reconecte-se e atualize a página.');
  });

  window.addEventListener('online', () => {
    if (!settled) setStatus('Internet restabelecida. Atualize a página para tentar novamente.');
  });

  import('./firebase-parcerias.js').catch((error) => {
    settled = true;
    window.clearTimeout(timeout);
    setStatus('Não foi possível carregar o módulo Firebase. Confira sua conexão e atualize a página. Se o problema persistir, verifique a disponibilidade do SDK.', 'error');
    console.error('Falha ao carregar firebase-parcerias.js:', error);
  });
})();
