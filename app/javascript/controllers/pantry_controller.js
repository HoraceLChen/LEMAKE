import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pantry"
export default class extends Controller {
  connect() {
    console.log("Connected to Pantry Controller");
  }
}
