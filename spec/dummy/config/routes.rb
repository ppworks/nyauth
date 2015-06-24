Rails.application.routes.draw do
  namespace :nyauth, path: :admin, as: :admin do
    resource :session, only: %i(new create destory)
  end
  mount Nyauth::Engine, at: '/', as: :nyauth

  resources :posts, only: %i(index)
  root 'pages#index'
end
