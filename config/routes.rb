Rails.application.routes.draw do
  get "members/login" => "members#login"
  post "members/login" => "members#login"
  post "members/logout" => "members#logout"
  get "cart/index"
  # post "products/:id" => "cart#create"
  post "cart/create" => "cart#create"
  root "home#top"
  resources :products
  resources :members
end
