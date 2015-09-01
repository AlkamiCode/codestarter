Rails.application.routes.draw do
  root to: "homepage#index"

  resources :companies, only: [:index]
  resources :orders, only: [:create, :index]
  resources :projects, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :cart_items, only: [:index, :create, :update, :destroy]

  namespace :companies, path: ':company', as: :company do
    resources :projects
    resources :orders, only: [:index, :show, :create]
    resources :users, only: [:show, :index, :new, :create, :update] do
      member do
        get :search
      end
    end
  end

  get  "/dashboard", to: "users#show"
  post "/dashboard", to: "addresses#create"
  get  "/cart",      to: "cart_items#index"
  post "/signup",    to: "users#create"
  put  "/update",    to: "users#update"
  post "/login",     to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
end
