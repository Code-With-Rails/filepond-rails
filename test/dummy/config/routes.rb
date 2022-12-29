# frozen_string_literal: true

Rails.application.routes.draw do
  mount Filepond::Rails::Engine => '/filepond'

  post '/', to: 'home#update'
  delete '/', to: 'home#destroy'
  root to: 'home#index'
end
