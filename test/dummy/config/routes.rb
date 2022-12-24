Rails.application.routes.draw do
  mount Filepond::Rails::Engine => "/filepond-rails"
end
