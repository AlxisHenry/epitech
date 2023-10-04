document.addEventListener("DOMContentLoaded", () => {
  const el = document.querySelector("footer div");
  let keys = [];
  document.addEventListener("keydown", (e) => {
		if (e.key.length === 1) {
      keys.push(e.key);
      if (keys.length > 42) keys.shift();
      el.innerHTML = `${keys.join("")} (${keys.length})`;
    }
  });
});
