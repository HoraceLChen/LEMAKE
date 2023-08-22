Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "dashboard", to: "meals#index", as: :dashboard
  resources :meals, only: [:new, :create, :edit, :update] do
    resources :uploaded_ingredients, only: [:index, :create]
    resources :recipes, only: [:index, :show]
  end
  resources :uploaded_ingredients, only: [:edit, :update]
end
