Rails.application.routes.draw do
  root to: "homepage#index"

  resources :companies, only: [:index]
  resources :orders, only: [:create, :index, :show]

  namespace :companies, path: ':company', as: :company do
    resources :projects, only: [:index, :show]
    resources :orders, only: [:index, :show, :create]
    resources :users, except: [:show] do
      resources :addresses, only: [:new, :create, :show]
    end
  end

  resources :projects, only: [:index, :show]
  resources :categories, only: [:show, :index]

  resources :cart_items, only: [:index, :create, :update, :destroy] do
    member do
      post :increment, :decrement
    end
  end

  namespace :admin do
    get "/dashboard", to: "admin#index"
    resources :items
    resources :orders, only: [:index, :show]
    resources :sales, only: [:index, :new, :create] do
      member do
        post :end_sale
      end
    end
  end

  get "/dashboard", to: "users#show"
  post "/dashboard", to: "addresses#create"
  get "/cart", to: "cart_items#index"
  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
