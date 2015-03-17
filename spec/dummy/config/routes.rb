Rails.application.routes.draw do
  mount Nyauth::Engine, at: '/admin', as: :nyauth_admin # FIXME: separate URL helper
  mount Nyauth::Engine, at: '/', as: :nyauth

  resources :posts, only: %i(index)
  root 'pages#index'
end
