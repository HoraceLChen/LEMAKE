import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favourites"
export default class extends Controller {
  static targets = [ "favouriteLink" ]

  connect() {
    console.log("You've connected to the Favourites Controller");
    console.log(this.favouriteLinkTarget);
  }

  toggle(event) {
    event.preventDefault();
    const url = this.favouriteLinkTarget.dataset.url;
    const token = document.getElementsByName('csrf-token')[0].content
    fetch(url, {
      method: "PATCH",
      headers: {
      "X-CSRF-Token": token
      }
    })
    .then(response => {
      if (response.ok) {
        const heartIcon = this.favouriteLinkTarget.querySelector('i'); // Assuming the icon is an <i> element inside the link
        if (heartIcon.classList.contains('fa-regular')) {
          heartIcon.classList.remove('fa-regular');
          heartIcon.classList.add('fa-solid');
        } else {
          heartIcon.classList.remove('fa-solid');
          heartIcon.classList.add('fa-regular');
        }
      } else {
      console.error('Error:', response.statusText);
      }
  })
    .catch(error => console.error('Fetch Error:', error));
  }
  }
