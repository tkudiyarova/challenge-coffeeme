ChallengeCoffeeme::Application.routes.draw do
  resources :users
  resources :drinks
  resources :orders

  root 'orders#index'
end
