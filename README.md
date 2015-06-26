# Nyauth

### application_controller.rb

```ruby
class ApplicationController < ActionController::Base
  include Nyauth::SessionConcern
end
```

### migration

```ruby
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :password_salt, null: false
      t.string :nickname
      t.datetime :confirmed_at
      t.string :confirmation_key
      t.datetime :confirmation_key_expired_at
      t.string :reset_password_key
      t.datetime :reset_password_key_expired_at

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
```

### model

```ruby
class User < ActiveRecord::Base
  include Nyauth::Authenticatable
  include Nyauth::Confirmable
  include Nyauth::NewPasswordAbility
end
```

### config/routes.rb

```ruby
Rails.application.routes.draw do
  # for admin
  namespace :nyauth, path: :admin, as: :admin do
    resource :session, only: %i(new create destory)
  end

  # for user
  mount Nyauth::Engine => "/"
end
```

```
rake routes
```

```ruby
Prefix Verb URI Pattern Controller#Action
nyauth      /nyauth     Nyauth::Engine

Routes for Nyauth::Engine:
              registration POST   /registration(.:format)                             nyauth/registrations#create
          new_registration GET    /registration/new(.:format)                         nyauth/registrations#new
                   session POST   /session(.:format)                                  nyauth/sessions#create
               new_session GET    /session/new(.:format)                              nyauth/sessions#new
                           DELETE /session(.:format)                                  nyauth/sessions#destroy
             edit_password GET    /password/edit(.:format)                            nyauth/passwords#edit
                  password PATCH  /password(.:format)                                 nyauth/passwords#update
                           PUT    /password(.:format)                                 nyauth/passwords#update
     confirmation_requests POST   /confirmation_requests(.:format)                    nyauth/confirmation_requests#create
  new_confirmation_request GET    /confirmation_requests/new(.:format)                nyauth/confirmation_requests#new
              confirmation GET    /confirmations/:confirmation_key(.:format)          nyauth/confirmations#update
   reset_password_requests POST   /reset_password_requests(.:format)                  nyauth/reset_password_requests#create
new_reset_password_request GET    /reset_password_requests/new(.:format)              nyauth/reset_password_requests#new
       edit_reset_password GET    /reset_passwords/:reset_password_key/edit(.:format) nyauth/reset_passwords#edit
            reset_password PATCH  /reset_passwords/:reset_password_key(.:format)      nyauth/reset_passwords#update
                           PUT    /reset_passwords/:reset_password_key(.:format)      nyauth/reset_passwords#update
```

```
new_session_path_for(:user) # /session/new
new_session_path_for(:admin) # /admin/session/new
```
