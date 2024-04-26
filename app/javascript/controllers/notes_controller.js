import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notes"
export default class extends Controller {
  connect() {
    // console.log("hello");
  }

  addNotes(event) {
    event.preventDefault()
    // console.log();
  }
}
