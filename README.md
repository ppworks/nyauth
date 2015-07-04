# Nyauth

Simple & modualbe authentication gem

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
      t.string :nickname
      # Authenticatable
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :password_salt, null: false
      t.string :reset_password_key
      t.datetime :reset_password_key_expired_at
      # Confirmable
      t.datetime :confirmed_at
      t.string :confirmation_key
      t.datetime :confirmation_key_expired_at

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
end
```

```ruby
class Admin < ActiveRecord::Base
  include Nyauth::Authenticatable
  #include Nyauth::Confirmable
end
```

### config/routes.rb

```ruby
Rails.application.routes.draw do
  # for admin
  namespace :nyauth, path: :admin, as: :admin do
    # concerns :nyauth_registrable
    concerns :nyauth_authenticatable
    # concerns :nyauth_confirmable
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

### Generator

```
rails g nyauth:install
```

```
rails g nyauth <MODEL>
rails g nyauth User
rails g nyauth Admin
```

```
rails g nyauth:views
```

### Customize

Change redirect path after action.

Please set NYAUTH_ENCRYPTION_SECRET ENV like following.

```
export NYAUTH_ENCRYPTION_SECRET=`bundle exec rake secret`
```

Or edit `config/initializers/nyauth.rb`

```
nyauth.configure do |config|
  config.encryption_secret = ENV['NYAUTH_ENCRYPTION_SECRET'] || ENV['SECRET_KEY_BASE']
  config.confirmation_expire_limit = 1.hour
  config.reset_password_expire_limit = 1.hour
  config.redirect_path do |urls|
    # config.redirect_path_after_sign_in = -> (client_name) {
    #  if client_name == :admin
    #    urls.admin_secret_notes_path
    #  else
    #    urls.root_path
    #  end
    #}
    # config.redirect_path_after_sign_in = -> (client_name) {}
    # config.redirect_path_after_sign_out = -> (client_name) {}
    # config.redirect_path_after_registration = -> (client_name) {}
    # config.redirect_path_after_create_request_confirmation = -> (client_name) {}
    # config.redirect_path_after_update_confirmation = -> (client_name) {}
    # config.redirect_path_after_reset_password_request = -> (client_name) {}
    # config.redirect_path_after_reset_password = -> (client_name) {}
    # config.redirect_path_after_update_password = -> (client_name) {}
  end
end
```

I18n

```
ja:
  flash:
    nyauth:
      passwords:
        update:
          notice: 'パスワードを更新しました'
      registrations:
        create:
          notice: '登録完了しました'
      sessions:
        create:
          notice: 'ログインしました'
        destroy:
          notice: 'ログアウトしました'
      confirmations:
        update:
          notice: 'メールアドレスの確認をしました'
      confirmation_requests:
        create:
          notice: 'メールアドレスへ確認メールを送信しました'
      reset_password_requests:
        create:
          notice: 'メールアドレスへパスワードリセットの案内を送信しました'
      reset_passwords:
        update:
          notice: 'パスワードを再設定しました'
  activerecord:
    errors:
      messages:
        key_expired: 'URLの有効期限が切れてしまいました'
  errors:
    messages:
      invalid_email_or_password: 'ログイン情報に誤りがあります'
```
