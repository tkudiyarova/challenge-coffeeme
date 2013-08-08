ChallengeCoffeeme::Application.routes.draw do
  resources :posts
  resources :users

  root 'dashboard#index'
end
