Rails.application.routes.draw do
  mount Nyauth::Engine => "/"

  resources :posts, only: %i(index)
  root 'pages#index'
end
