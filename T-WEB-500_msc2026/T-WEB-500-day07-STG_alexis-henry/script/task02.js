document.addEventListener("DOMContentLoaded", () => {
  const el = document.querySelector("footer div");

  el.addEventListener("click", function () {
    let name = "";
    while (name === "" || name === null) name = prompt("What's your name ?");
    let confirm = window.confirm(`Are you sure that ${name} is your name ?`);
    if (confirm) {
      let content = `Hello ${name} !`
      el.innerHTML = content;
      alert(content);
    }
  });
});
