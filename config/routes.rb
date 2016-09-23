Rails.application.routes.draw do
  root to: 'home#cabinet'

  devise_for :users
end
