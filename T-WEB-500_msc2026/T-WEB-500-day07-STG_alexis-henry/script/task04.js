document.addEventListener("DOMContentLoaded", function () {
  const btns = [
    document.querySelector("footer div > button"),
    document.querySelector("footer div > button:nth-child(2)"),
  ];
  btns.forEach((btn, i) => {
    btn.addEventListener("click", function () {
      let currentSize = parseInt(document.body.style.fontSize) || 16;
      document.body.style.fontSize =
        i === 0 ? `${currentSize + 4}px` : `${currentSize - 4}px`;
    });
  });
  const select = document.querySelector("footer div > select");
  select.addEventListener("change", function () {
    document.body.style.backgroundColor = this.value;
  });
});
