Rails.application.routes.draw do
  root "home#top"
  resources :products
  resources :members
end
