import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="expanding-card"

export default class extends Controller {
  connect() {
    console.log('connected');
  }
}
