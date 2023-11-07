Rails.application.routes.draw do
  get "members/login" => "members#login"
  post "members/login" => "members#session_create"
  post "members/logout" => "members#logout"
  get "cart/index"
  post "cart/create" => "cart#create"
  post "cart/:member_id/:product_id/destroy" => "cart#destroy"
  post "orders/create" => "orders#create"
  root "home#top"
  resources :orders
  resources :products
  resources :members
end
