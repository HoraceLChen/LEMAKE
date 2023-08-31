import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pantry"
export default class extends Controller {
  static targets = ["ingredient", "icon", "popup", "form", "insert"]
  connect() {
    console.log("connected");
  }

  popUp() {
    console.log("popup");
    this.popupTarget.classList.add("open-popup")
  }


  save(event){
    const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content")
    console.log("SUCCESS");
    console.log(event);
    console.log(this.formTarget.action);
    const url = this.formTarget.action;
    const data = event.currentTarget.dataset.ingredientId;
    fetch(url, {
      method: "POST",
      body: JSON.stringify({ ingredient_id: data }),
      headers: {"content-type": "application/json", 'X-CSRF-Token': csrf},
    })
      .then(response => response.json())
      .then((data) => {
        this.updatePopup(data)
      })
  }

  updatePopup(data) {
    const popup = this.insertTarget;

    if (data.status === 'created') {
      const newDiv = document.createElement("div");
      newDiv.className = "added-ingredients";
      newDiv.innerHTML = data.ingredient.name;
      popup.appendChild(newDiv);
    } else if (data.status === 'destroyed') {
      const ingredientDivs = popup.querySelectorAll('.added-ingredients');
      ingredientDivs.forEach(div => {
        if (div.innerHTML === data.ingredient.name) {
          div.remove();
        }
      });
    }
  }

  seeMore(event){
    console.log(event.currentTarget);
    const category = event.currentTarget.dataset.category;
    this.ingredientTargets.forEach((ingredient) => {
      if(ingredient.dataset.category === category){
        ingredient.classList.toggle("d-none")
        this.iconTargets.forEach((icon)=>{
          if(icon.dataset.category === category) {
            if(ingredient.classList.contains("d-none")){
              icon.outerHTML = `<i class="fa-solid fa-caret-down pt-2" style="color: #484846;" data-pantry-target="icon" data-category="${icon.dataset.category}"></i>`
             } else{
              icon.outerHTML = `<i class="fa-solid fa-caret-up pt-2" style="color: #484846;" data-pantry-target="icon" data-category="${icon.dataset.category}"></i>`
             }
          }
        })
      }
    })
  }
}
