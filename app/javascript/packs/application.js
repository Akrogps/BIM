import "bootstrap";
import Bloodhound from "bloodhound-js"

const input = document.getElementById('restaurant_name')

input.addEventListener('input', (event) => {
  fetch("/restaurants/autocomplete?query=" + event.target.value)
  .then((data) => {
  console.log(data.json())
});
});
