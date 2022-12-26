# frozen_string_literal: true

Filepond::Rails::Engine.routes.draw do
  # For details regarding FilePond endpoints, please refer to https://pqina.nl/filepond/docs/api/server

  # https://pqina.nl/filepond/docs/api/server/#fetch
  post 'active_storage/fetch', to: 'ingress#fetch'

  # https://pqina.nl/filepond/docs/api/server/#remove
  delete 'active_storage/remove', to: 'ingress#remove'
end
