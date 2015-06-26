Nyauth::Engine.routes.draw do
  resource :registration, only: %i(new create)
  resource :session, only: %i(new create destroy)
  resource :password, only: %i(edit update)
  resources :confirmation_requests, only: %i(new create)
  get '/confirmations/:confirmation_key' => 'confirmations#update', as: :confirmation
  resources :reset_password_requests, only: %i(new create)
  resources :reset_passwords, param: :reset_password_key, only: %i(edit update)
  Nyauth.configuration.setup_redirect_path
end
