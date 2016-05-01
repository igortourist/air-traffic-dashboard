Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'planes#index'
  post 'flight', to: 'planes#flight'
  get 'activities/:id', to: 'planes#activities', as: :activities

  devise_for :users

  mount Resque::Server.new, at: '/jobs/resque'
end
