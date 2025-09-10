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

  const expandToggle = document.getElementById("expand-all");
  if (expandToggle) {
    expandToggle.addEventListener("change", function () {
      document.querySelectorAll("details").forEach(d => {
        d.open = expandToggle.checked;
      });
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
