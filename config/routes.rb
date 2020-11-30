# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#index'

  get :login, to: 'users#new_login'
  post :login, to: 'users#login'
  delete :logout, to: 'users#logout'
  get :profile, to: 'users#show'
  post :import_file, to: 'users#import_file'
  resources :subjects, only: %i[index show]
  resources :attempts, only: %i[new create show]
end
