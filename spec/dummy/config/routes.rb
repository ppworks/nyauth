Rails.application.routes.draw do
  mount Nyauth::Engine => "/"
  root 'pages#index'
end
