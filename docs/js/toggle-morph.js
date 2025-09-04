document.addEventListener("DOMContentLoaded", () => {
  const cb = document.getElementById("toggle-morph");
  if (cb) {
    cb.addEventListener("change", () => {
      document.body.classList.toggle("show-morph", cb.checked);
    });
  }
});
