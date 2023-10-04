document.addEventListener("DOMContentLoaded", function () {
  const canvas = document.querySelector("footer div > canvas");
  const parent = canvas.parentElement;
  parent.style.position = "relative";
  canvas.style.position = "absolute";
  let offsetY, offsetX;

  canvas.setAttribute("draggable", true);
  canvas.addEventListener("dragstart", function (e) {
    offsetX = e.clientX - canvas.offsetLeft;
    offsetY = e.clientY - canvas.offsetTop;
  });

  canvas.addEventListener("dragend", function (e) {
    let x = Math.min(
      Math.max(e.clientX - offsetX, -5),
      parent.offsetWidth - canvas.offsetWidth - 5
    );
    y = Math.min(
      Math.max(e.clientY - offsetY, 0),
      parent.offsetHeight - canvas.offsetHeight
    );
    canvas.style.left = `${x}px`;
    canvas.style.top = `${y}px`;
    displayNewCoordinates(x, y);
  });
});

function displayNewCoordinates(x, y) {
  document.querySelector(
    "footer div:nth-child(2)"
  ).innerHTML = `New coordinates => {x:${x}, y:${y}}`;
}
