Rails.application.routes.draw do
  root to: 'home#cabinet'

  resources :users do
    resources :games, only: ['new', 'create']
  end

  devise_for :users
end
