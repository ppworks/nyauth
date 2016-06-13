# Nyauth

[![Code Climate](https://codeclimate.com/github/ppworks/nyauth/badges/gpa.svg)](https://codeclimate.com/github/ppworks/nyauth)
[![Build Status](https://travis-ci.org/ppworks/nyauth.svg?branch=master)](https://travis-ci.org/ppworks/nyauth)

Simple & modulable authentication gem

[CHANGE LOG](https://github.com/ppworks/nyauth/blob/master/CHANGELOG.md)

### application_controller.rb

```ruby
class ApplicationController < ActionController::Base
  include Nyauth::ControllerConcern
  before_action -> { require_authentication! as: nyauth_client_name }
  helper_method :current_user

  private

  def current_user
    current_authenticated(as: :user)
  end
end
```

For the current signed-in user, this helper is available:

```ruby
current_user
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

```ruby
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

```ruby
nyauth.configure do |config|
  config.encryption_secret = ENV['NYAUTH_ENCRYPTION_SECRET'] || ENV['SECRET_KEY_BASE']
  config.confirmation_expire_limit = 1.hour
  config.reset_password_expire_limit = 1.hour
  config.mail_delivery_method = :deliver_now
  config.parent_controller = "ApplicationController"
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

```yaml
en:
  flash:
    nyauth:
      passwords:
        update:
          notice: 'updated password'
      registrations:
        create:
          notice: 'registration success'
      sessions:
        create:
          notice: 'sign in success'
        destroy:
          notice: 'sign out success'
      confirmations:
        update:
          notice: 'confirmed'
      confirmation_requests:
        create:
          notice: 'sent mail'
      reset_password_requests:
        create:
          notice: 'sent mail'
      reset_passwords:
        update:
          notice: 'updated password'
  activerecord:
    errors:
      messages:
        key_expired: 'This URL is expired'
  errors:
    messages:
      invalid_email_or_password: 'Invalid email or password'
      invalid_email: 'Invalid email'
  nav:
    nyauth:
      common:
        send: 'Send'
        set: 'Set'
        update: 'Update'
      sessions:
        new: 'Sign in'
        destroy: 'Sign out'
      registrations:
        new: 'Sign up'
      passwords:
        edit: 'Change password'
      reset_password_requests:
        new: 'Reset password'
      confirmation_requests:
        new: 'Confirm E-mail address'
```

## test

spec/rails_helper.rb

```ruby
require 'nyauth/test/macros'

RSpec.configure do |config|
  config.include Nyauth::Test::ControllerMacros, type: :controller
  config.include Nyauth::Test::FeatureMacros, type: :feature
end
```

use macro

```
background { sign_in(user) }
```
