import "bootstrap";
import Bloodhound from "bloodhound-js"

const input = document.getElementById('restaurant_name')

input.addEventListener('input', (event) => {
  fetch("/restaurants/autocomplete?query=" + event.target.value)
  .then((data) => {
    return data.json()
  })
  .then((data) => {
    const items = input.parentNode.querySelectorAll('.dropdown-item')
    console.log(items)
    if (items) {
      items.forEach(el => el.remove());
    }

    data.forEach(element => {
      input.parentNode.insertAdjacentHTML('beforeend', `
        <div class="dropdown-item">
          ${element}
        </div>
      `);
    })
  })
});
