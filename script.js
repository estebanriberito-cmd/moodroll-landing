// ---- Reveal slider (hero signature interaction) ----
(function () {
  const frame = document.getElementById('revealWidget').querySelector('.reveal-frame');
  const before = document.getElementById('revealBefore');
  const handle = document.getElementById('revealHandle');
  const beforeImg = before.querySelector('img');

  let dragging = false;

  function setPosition(clientX) {
    const rect = frame.getBoundingClientRect();
    let pct = ((clientX - rect.left) / rect.width) * 100;
    pct = Math.max(6, Math.min(94, pct));
    before.style.width = pct + '%';
    handle.style.left = pct + '%';
    beforeImg.style.width = (10000 / pct) + '%';
  }

  function start(e) {
    dragging = true;
    move(e);
  }
  function move(e) {
    if (!dragging) return;
    const x = e.touches ? e.touches[0].clientX : e.clientX;
    setPosition(x);
  }
  function end() { dragging = false; }

  frame.addEventListener('mousedown', start);
  frame.addEventListener('touchstart', start, { passive: true });
  window.addEventListener('mousemove', move);
  window.addEventListener('touchmove', move, { passive: true });
  window.addEventListener('mouseup', end);
  window.addEventListener('touchend', end);
})();
