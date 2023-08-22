Rails.application.routes.draw do
  get 'recipes/index'
  get 'recipes/show'
  get 'uploaded_ingredients/index'
  get 'uploaded_ingredients/create'
  get 'uploaded_ingredients/update'
  get 'meals/index'
  get 'meals/new'
  get 'meals/create'
  get 'meals/edit'
  get 'meals/update'
  devise_for :users
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :meals, only: [:index, :new, :create, :edit, :update] do
    resources :uploaded_ingredients, only: [:index, :edit, :create, :update] do
      resources :recipes, only: [:index, :show]
    end
  end
  # Defines the root path route ("/")
  root to: "pages#home"
end
