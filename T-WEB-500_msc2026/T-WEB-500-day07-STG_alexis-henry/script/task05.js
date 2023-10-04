document.addEventListener("DOMContentLoaded", function () {
  const canvas = document.querySelector("footer div > canvas");

  const ctx = canvas.getContext("2d");
  ctx.beginPath();
  ctx.moveTo(6, 6);
  ctx.lineTo(14, 10);
  ctx.lineTo(6, 14);
  ctx.closePath();
  ctx.lineWidth = 1;
  ctx.strokeStyle = "white";
  ctx.stroke();

  let pre = document.querySelector("section > pre").innerHTML;
  let url = pre.includes("https://")
    ? `https://${pre.split("https://")[1].trim()}`
    : null;
  if (url === null) throw new Error("Audio URL not found.");
  const sound = new Audio(url);

  canvas.addEventListener("click", () => sound.play());

  const btns = [...document.querySelectorAll("footer div > button")];

  btns.forEach((btn, i) => {
    btn.addEventListener("click", function (e) {
      if (i === 0) {
        sound.paused ? sound.play() : sound.pause();
      } else if (i === 1) {
        sound.pause();
        sound.currentTime = 0;
      } else {
        sound.muted = !sound.muted;
      }
    });
  });
});
