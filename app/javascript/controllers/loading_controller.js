import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  connect() {
    console.log("loading connected");
  }

  leChef(event){
    console.log("ok");
    const overlay = document.createElement("div");
    overlay.classList.add("loading-overlay");

    const spinner = document.createElement("img");
    spinner.style.position = "fixed";
    spinner.style.top = "50%";
    spinner.style.left = "50%";
    spinner.style.width = "200px";
    spinner.style.objectFit = "cover";
    const imgUrl = event.target.dataset.image;
    spinner.classList.add("spinner");
    spinner.src = imgUrl
    overlay.appendChild(spinner);
    document.body.appendChild(overlay);
  }
}
