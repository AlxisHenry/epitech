document.addEventListener("DOMContentLoaded", function () {
  const container = document.querySelector("section div");
  const ul = document.createElement("ul");
  container.append(ul);

  document
    .querySelector("form.create")
    .addEventListener("submit", function (e) {
      e.preventDefault();
      updateList(ul);
    });

  document
    .querySelector("form.search")
    .addEventListener("submit", function (e) {
      e.preventDefault();
      searchByOption();
    });

  document
    .querySelector("input[type='reset']")
    .addEventListener("click", function () {
      reset();
    });
});

function updateList(list) {
  let bulletElement = document.createElement("li");
  bulletElement.innerText = document.querySelector("input").value;
  bulletElement.classList.add(document.querySelector("select").value);
  list.append(bulletElement);
  document.querySelector("form.create").reset();
}

function searchByOption() {
  let option = document.querySelector("form.search select").value;
  document.querySelectorAll("li").forEach((li) => {
    li.style.display = li.classList.contains(option) ? "list-item" : "none";
  });
}

function reset() {
  document.querySelectorAll("li").forEach((li) => {
    li.style.display = "list-item";
  });
}
