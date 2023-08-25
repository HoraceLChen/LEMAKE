import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-increment"
export default class extends Controller {
  static targets=["input"]
  connect() {
  }

  down(){
    this.inputTarget.value -= 1
  }

  up(){
    this.inputTarget.value += 1
  }
}
