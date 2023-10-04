document.addEventListener("DOMContentLoaded", function () {
  document
    .querySelectorAll("a:not([target='_blank'])")
    .forEach(function (link) {
      link.style.opacity = 0.5;
    });
});
