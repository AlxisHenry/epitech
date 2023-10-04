document.addEventListener("DOMContentLoaded", function () {
  const container = document.querySelector("section div");
  const ul = document.createElement("ul");
  container.append(ul);
  document.querySelector("form").addEventListener("submit", function (e) {
    e.preventDefault();
    let bulletElement = document.createElement("li");
    bulletElement.innerText = document.querySelector("input").value;
    bulletElement.classList.add(document.querySelector("select").value);
    ul.append(bulletElement);
  });
});
