Nyauth::Engine.routes.draw do
  resource :registration, only: %i(new create)
  resource :session, only: %i(new create destroy)
  resource :password, only: %i(edit update)
  resources :confirmation_requests, only: %i(new create)
  get '/confirmations/:confirmation_key' => 'confirmations#update', as: :confirmation
  resources :new_password_requests, only: %i(new create)
  resources :new_passwords, param: :new_password_key, only: %i(edit update)
  Nyauth.configuration.setup_redirect_path
end
