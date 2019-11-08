import "bootstrap";
import Bloodhound from "bloodhound-js"
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from '../plugins/init_mapbox';

initMapbox();

const input = document.getElementById('restaurant_name')

input.addEventListener('input', (event) => {
  fetch("/restaurants/autocomplete?query=" + event.target.value)
  .then((data) => {
    return data.json()
  })
  .then((data) => {
    const items = input.parentNode.querySelectorAll('.dropdown-item')
    if (items) {
      items.forEach(el => el.remove());
    }

    data.forEach(element => {
      input.parentNode.insertAdjacentHTML('beforeend', `
        <div class="dropdown-item search-result">
          ${element}
        </div>
      `);
    })

    const results = input.parentNode.querySelectorAll('.search-result')
    results.forEach(result => {
      result.addEventListener('click', (e) => {
        event.stopPropagation();
        input.value = e.target.innerText;
      })
    })
  });
});

$(window).click(function() {
    const items = input.parentNode.querySelectorAll('.dropdown-item')
    if (items) {
      items.forEach(el => el.remove());
    }
});
