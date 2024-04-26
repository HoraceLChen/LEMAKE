import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload"
export default class extends Controller {
  connect() {
    // console.log('Connected to Upload Controller');
  }

  submit() {
    // console.log(this.element);
    this.element.submit();
  }
}
