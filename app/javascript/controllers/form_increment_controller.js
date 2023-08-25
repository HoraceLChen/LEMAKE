import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-increment"
export default class extends Controller {
  static targets=["input"]
  connect() {
  }

  timeDown(){
    this.inputTarget.value = (parseInt(this.inputTarget.value, 10) - 5);
  }
  timeUp(){
    this.inputTarget.value = (parseInt(this.inputTarget.value, 10) + 5);
  }

  peopleDown(){
    this.inputTarget.value = (parseInt(this.inputTarget.value, 10) - 1);
  }

  peopleUp(){
    this.inputTarget.value = (parseInt(this.inputTarget.value, 10) + 1);
  }
}
