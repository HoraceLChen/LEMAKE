import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pantry"
export default class extends Controller {
  static targets = ["ingredient", "icon", "popup"]
  connect() {
    console.log("connected");
  }

  popUp() {
    console.log("popup");
    this.popupTarget.classList.add("open-popup")
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
