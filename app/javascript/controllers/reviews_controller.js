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

    fetch(form.action, {
      method: 'POST',
      body: formData,
    })
      .catch(error => {
        console.error('Failed to submit the form.', error);
      });
  }
}
