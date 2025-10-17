document.addEventListener("DOMContentLoaded", function () {

  const morphToggle = document.getElementById("toggle-morph");

  function applyToggle(checked) {
    document.querySelectorAll("[data-hyphen][data-plain]").forEach(el => {
      el.textContent = checked
        ? el.getAttribute("data-hyphen")
        : el.getAttribute("data-plain");
    });
  }

  if (morphToggle) {
    // Initialize
    applyToggle(morphToggle.checked);

    // Respond to changes
    morphToggle.addEventListener("change", function () {
      applyToggle(this.checked);
    });
  }

  const vocabToggle = document.getElementById("vocab-all");
  if (vocabToggle) {
    vocabToggle.addEventListener("change", function () {
      // Show vocab logic here
    });
  }

  const picToggle = document.getElementById("show-pic");
  if (picToggle) {
    picToggle.addEventListener("click", function () {
      // Show picture logic here
    });
  }
});



/* OLD
document.addEventListener("DOMContentLoaded", function () {
  const byId = (id) => document.getElementById(id);
  const toggle = byId("toggle-morph") || byId("toggle-hyphens");

  function applyToggle(checked) {
    document.querySelectorAll("[data-hyphen][data-plain]").forEach(el => {
      el.textContent = checked ? el.getAttribute("data-hyphen") : el.getAttribute("data-plain");
    });
  }

  // Initialize based on checkbox state (default to plain if no checkbox)
  applyToggle(toggle ? toggle.checked : false);

  if (toggle) {
    toggle.addEventListener("change", function () {
      applyToggle(this.checked);
    });
  }
});
*/
