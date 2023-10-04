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
    type = document.querySelector("select").value || null,
    tags = document.querySelector("input[name='tags']").value || null;

  let tagEditor = document.createElement("div");
  let tagsInput = document.createElement("input");
  let submitTags = document.createElement("input");

  submitTags.type = "button";
  submitTags.value = "Submit";
  submitTags.disabled = true;

  tagsInput.value = tags || null;
  tagsInput.addEventListener("change", function () {
    submitTags.disabled = false;
  });

  submitTags.addEventListener("click", function () {
    tags = tagsInput.value;
    bulletElement.innerText = `${value} - Tags: ${tags || "none"}`;
    bulletElement.classList.add(type);
    bulletElement.append(tagEditor);
    submitTags.disabled = true;
  });

  tagEditor.append(tagsInput);
  tagEditor.append(submitTags);

  bulletElement.innerText = `${value} - Tags: ${tags || "none"}`;
  bulletElement.classList.add(type);
  bulletElement.append(tagEditor);
  if (value && type) {
    list.append(bulletElement);
    document.querySelector("form.create").reset();
  }
}

function search() {
  let searchValue =
      document.querySelector("form.search input").value.toLowerCase() || null,
    types = Array.from(
      document.querySelectorAll("form.search input[name='types[]'")
    )
      .filter((input) => input.checked)
      .map((input) => input.value),
    reverse = document.querySelector(
      "form.search input[type='checkbox']"
    ).checked,
    tags =
      document
        .querySelector("form.search input[name='tags']")
        .value.toLowerCase() || null,
    tagsExcluded =
      document
        .querySelector("form.search input[name='tags-excluded']")
        .value.toLowerCase() || null;

  if (!searchValue && !types && !reverse && !tags && !tagsExcluded) return;

  const items = document.querySelectorAll("li");

  // Search filter
  items.forEach((item) => {
    if (searchValue) {
      if (
        (!item.innerText.toLowerCase().includes(searchValue) && reverse) ||
        (item.innerText.toLowerCase().includes(searchValue) && !reverse)
      ) {
        item.style.display = "flex";
      } else {
        item.style.display = "none";
      }
    }
  });

  // Types filter
  items.forEach((item) => {
    if (item.style.display !== "none" && types.length > 0) {
      item.style.display = types.includes(item.classList[0]) ? "flex" : "none";
    }
  });

  // Tags filter
  items.forEach((item) => {
    if (item.style.display !== "none") {
      if (tags) {
        let liTags = item.innerText.split(": ")[1]?.split(" ");
        for (let tag of tags?.split(" ") || []) {
          item.style.display = liTags.includes(tag) ? "flex" : "none";
        }
      }
    }
  });

  // Tags excluded filter
  items.forEach((item) => {
    if (item.style.display !== "none") {
      if (tagsExcluded) {
        let liTags = item.innerText.split(": ")[1]?.split(" ");
        for (let tag of tagsExcluded?.split(" ") || []) {
          item.style.display = liTags.includes(tag) ? "none" : "flex";
        }
      }
    }
  });
}

function reset() {
  document.querySelectorAll("li").forEach((li) => {
    li.style.display = "flex";
  });
}
