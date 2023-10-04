document.addEventListener("DOMContentLoaded", function () {
  const el = document.querySelector("footer div");
  el.innerHTML = 0;

  el.addEventListener("click", function () {
    el.innerHTML = parseInt(el.innerHTML) + 1 || 1;
  });
});
