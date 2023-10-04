const COOKIE_NAME = "acceptsCookies";

document.addEventListener("DOMContentLoaded", function () {
  if (getCookie(COOKIE_NAME) === "true") createButton();

  document.querySelector("footer div a").addEventListener("click", function () {
    setCookie(COOKIE_NAME, true, 1);
    createButton();
  });
});

function setCookie(name, value, days) {
  let date = new Date();
  date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
  let expires = "expires=" + date.toUTCString();
  document.cookie = name + "=" + value + ";" + expires + ";path=/";
}

function createButton() {
  document.querySelector("footer div").style.display = "none";
  let div = document.createElement("div"),
    button = document.createElement("button");
  button.textContent = "Delete the cookie";
  button.addEventListener("click", function () {
    deleteCookie("acceptsCookies");
    document.querySelector("footer div").style.display = "block";
    div.remove();
  });
  div.appendChild(button);
  document.querySelector("footer").appendChild(div);
}

function getCookie(name, retrieveValue = true) {
  let cookies = document.cookie.split("; "),
    value = null;
  for (let i = 0; i < cookies.length; i++) {
    let cookie = cookies[i].split("=");
    if (cookie[0] === name) {
      value = cookie[1];
    }
  }
  return retrieveValue ? value : value !== null;
}

function deleteCookie(name) {
  document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
}
