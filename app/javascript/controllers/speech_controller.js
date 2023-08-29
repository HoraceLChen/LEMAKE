import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="speech"
export default class extends Controller {
  static targets = ["form", "input", "ingredients"]
  connect() {
    console.log("connected")
  }

  record(){
    console.log("recording")
    const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
    const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    const recognition = new SpeechRecognition();
    recognition.start();
    recognition.onresult = (event) => {
      console.log(event.results[0][0].transcript)
      const recordedIngredients = event.results[0][0].transcript.split(" and ")
      console.log(recordedIngredients)
      recordedIngredients.forEach(ingredient => {
        const url = this.formTarget.action
        this.inputTarget.value = ingredient
        const data = new FormData(this.formTarget)
        fetch(url, {
          method: "POST",
          body: data,
          headers: {"Accept": "text/plain", 'X-CSRF-Token': csrf},
        })
          .then(response => response.text())
          .then((data) => {
            this.ingredientsTarget.insertAdjacentHTML("beforeend", data)
          })
        this.inputTarget.value = ""
      });

    }

    // recognition.onspeechend = () => {
    //   recognition.stop();
    // };

}
}
