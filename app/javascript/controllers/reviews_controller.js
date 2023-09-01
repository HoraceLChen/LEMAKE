import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reviews"
export default class extends Controller {
  static targets = ['form', 'content', 'notes'];

  connect() {
    console.log("connected to reviews");
  }

  submit(event) {
    const form = this.formTarget;
    const formData = new FormData(form);
    event.preventDefault()
    fetch(form.action, {
      method: 'POST',
      body: formData,
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();  // assuming server responds with json
    })
    .then(data => console.log(data))
    .catch(error => {
      console.error('Failed to submit the form.', error);
    });
  }
}
