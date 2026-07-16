// Mobile nav toggle
(function() {
  var toggle = document.querySelector('.nav-toggle');
  var nav = document.querySelector('.nav-links');

  if (toggle && nav) {
    toggle.addEventListener('click', function() {
      var isOpen = nav.classList.toggle('is-open');
      toggle.setAttribute('aria-expanded', isOpen);
    });

    // Close nav when clicking a link
    nav.querySelectorAll('a').forEach(function(link) {
      link.addEventListener('click', function() {
        nav.classList.remove('is-open');
        toggle.setAttribute('aria-expanded', 'false');
      });
    });
  }
})();
