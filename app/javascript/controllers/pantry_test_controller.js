import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pantry-test"
export default class extends Controller {
  connect() {
    console.log("connected to pantry test controller");
  }
}
