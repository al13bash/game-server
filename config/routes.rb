Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'home#cabinet'

  devise_for :users, controllers: { sessions: 'sessions' }

  resources :games, only: ['create']
end
