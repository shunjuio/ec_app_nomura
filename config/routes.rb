Rails.application.routes.draw do
  # get "members/login" => "members#login"
  # post "members/login" => "members#login"
  # post "members/logout" => "members#logout"
  get "cart/index"
  post "cart/create" => "cart#create"
  post "cart/:member_id/:product_id/destroy" => "cart#destroy"
  post "orders/create" => "orders#create"
  root "home#top"
  resources :orders
  resources :products
  # resources :members
  devise_for :members, controllers: {
    registrations: "members/registrations",
    sessions: "members/sessions"
  }
  devise_scope :member do
    get "members/login" => "members/sessions#new"
    get "members/new" => "members/registrations#new"
    get "members/:id/edit" => "members/registrations#edit"
    post "members/logout" => "members/sessions#destroy"
  end
end
