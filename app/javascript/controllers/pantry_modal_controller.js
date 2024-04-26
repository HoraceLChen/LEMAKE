import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pantry-modal"
export default class extends Controller {
  static values = {
    empty: Boolean
  }

  connect() {
    // console.log('Connected to the Pantry Modal');
    // console.log(this.emptyValue);

    if (this.emptyValue) {
      let myModal = new bootstrap.Modal(document.getElementById('pantryModal'));
      myModal.show();
    }
  }
}
