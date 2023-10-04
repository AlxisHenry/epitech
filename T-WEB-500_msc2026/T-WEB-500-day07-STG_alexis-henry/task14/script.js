document.addEventListener("DOMContentLoaded", function () {
  const container = document.querySelector("section div");
  const ul = document.createElement("ul");
  container.append(ul);

  document.querySelector("form").addEventListener("submit", function (e) {
    e.preventDefault();
    updateList(ul);
  });

  document
    .querySelector("form.search")
    .addEventListener("submit", function (e) {
      e.preventDefault();
      search();
    });

  document
    .querySelector("input[type='reset']")
    .addEventListener("click", function () {
      reset();
    });
});

function updateList(list) {
  let bulletElement = document.createElement("li");
  let value = document.querySelector("input").value || null,
    type = document.querySelector("select").value || null;
  bulletElement.innerText = value;
  bulletElement.classList.add(type);
  if (value && type) {
    list.append(bulletElement);
    document.querySelector("form.create").reset();
  }
}

function search() {
  let searchValue =
      document.querySelector("form.search input").value.toLowerCase() || null,
    type = document.querySelector("form.search select").value || null,
    reverse = document.querySelector(
      "form.search input[type='checkbox']"
    ).checked;

  if (!searchValue && !type && !reverse) return;

  const items = document.querySelectorAll("li");

  // Search filter
  items.forEach((item) => {
    if (searchValue) {
      if (
        (!item.innerText.toLowerCase().includes(searchValue) && reverse) ||
        (item.innerText.toLowerCase().includes(searchValue) && !reverse)
      ) {
        item.style.display = "list-item";
      } else {
        item.style.display = "none";
      }
    }
  });

  items.forEach((item) => {
    if (item.style.display !== "none" && type) {
      item.style.display = item.classList.contains(type) ? "list-item" : "none";
    }
  });
}

function reset() {
  document.querySelectorAll("li").forEach((li) => {
    li.style.display = "list-item";
  });
}
