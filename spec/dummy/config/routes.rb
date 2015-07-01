Rails.application.routes.draw do
  namespace :nyauth, path: :admin, as: :admin do
    concerns :nyauth_authenticatable
  end
  mount Nyauth::Engine, at: '/', as: :nyauth

  resources :posts, only: %i(index)
  root 'pages#index'
end
