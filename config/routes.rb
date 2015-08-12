Rails.application.routes.draw do
  root to: "welcome#index"
  resources :items, only: [:index, :show]
  resources :categories, only: [:show, :index]
  resources :cart_items, only: [:index, :create, :destroy] do
    member do
      post :increment, :decrement
    end
  end
  resources :users, except: [:show] do
    resources :addresses, only: [:new, :create, :show]
  end
  namespace :admin do
    get "/dashboard", to: "admin#index"
    resources :items
    resources :orders, only: [:index, :show]
  end
  resources :orders, only: [:index, :show, :create]
  get "/dashboard", to: "users#show"
  post "/dashboard", to: "addresses#create"
  get "/cart", to: "cart_items#index"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
