document.addEventListener("DOMContentLoaded", () => {

  console.log("hhh");
  const textarea = document.querySelector(".post-area__textarea");
  const counter = document.getElementById("char-count");

  if (textarea && counter) {
    counter.textContent = `${textarea.value.length} / 140`;
    textarea.addEventListener("input", () => {
      counter.textContent = `${textarea.value.length} / 140`;
    });
  }
});