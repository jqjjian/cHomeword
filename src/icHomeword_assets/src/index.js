import { icHomeword } from "../../declarations/icHomeword";

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const button = e.target.querySelector("button");

  const name = document.getElementById("name").value.toString();

  button.setAttribute("disabled", true);

  // Interact with foo actor, calling the greet method
  const greeting = await icHomeword.greet(name);

  button.removeAttribute("disabled");

  document.getElementById("greeting").innerText = greeting;

  return false;
});

// const qsort = arr => (arr.length > 1 ? (([h, ...t]) => [].concat(qsort(t.filter(x => x <= h)),[h],qsort(t.filter(x => x > h))))(arr) : arr);
