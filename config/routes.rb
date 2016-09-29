Rails.application.routes.draw do
  root to: 'home#cabinet'

  devise_for :users, controllers: { sessions: 'sessions' }

  resources :games, only: ['create']
end
