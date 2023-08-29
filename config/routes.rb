Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'meals#index', as: :authenticated_root

    resources :users, only: [] do
      member do
        get 'pantry', to: 'pantry_ingredients#index'
        post 'pantry', to: 'pantry_ingredients#create'
        get 'bookmarks', to: 'bookmarks#index'

      end
    end

    resources :pantry_ingredients, only: [:destroy]
  end

  root to: "pages#home"

  get "dashboard", to: "meals#index", as: :dashboard

  resources :meals, only: [:new, :create, :edit, :update] do
    resources :uploaded_ingredients, only: [:index, :create]
    resources :recipes, only: [:index, :show]
    member do
      patch :favourite_toggle
      patch :upload_photo
    end
  end
  resources :uploaded_ingredients, only: [:destroy]
  resources :ingredients, only: [:create]
  resources :reviews, only: [:create]


end
