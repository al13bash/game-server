Rails.application.routes.draw do
  if Rails.env.development?
    require 'sidekiq/web'
    authenticate :user do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  mount ActionCable.server => '/cable'

  root to: 'home#cabinet'

  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  resources :games, only: ['create']

  get '/rating', to: 'ratings#index'
end
