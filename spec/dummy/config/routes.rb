Rails.application.routes.draw do
  namespace :nyauth, path: :admin, as: :admin do
    concerns :nyauth_authenticatable
  end
  mount Nyauth::Engine, at: '/', as: :nyauth

  resource :secret_page, only: %i(show)
  root 'pages#index'
end
