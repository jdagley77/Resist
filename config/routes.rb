Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :users

  resources :issues


end
