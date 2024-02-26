fetch("./containers.php", {
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
})
  .then((response) => {
    return response.json();
  })
  .then((data) => {
    document.querySelector(".loader").style.display = "none";
    document.querySelector(".containers").innerHTML = data.containers;

    const containers = document.querySelectorAll(".container");

    containers.forEach((container) => {
      container.addEventListener("click", (e) => {
        if (container.classList.contains("active")) {
          container.classList.remove("active");
          container.classList.add("unactive");
        } else {
          container.classList.remove("unactive");
          container.classList.add("active");
        }
      });
    });
  })
  .catch((error) => {
    console.log(error);
  });
