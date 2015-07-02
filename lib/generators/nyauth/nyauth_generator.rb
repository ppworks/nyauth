require 'rails/generators/active_record'

class Nyauth::NyauthGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path("../templates", __FILE__)
  
  def copy_nyauth_migration
    migration_template "migration.rb", "db/migrate/add_nyauth_to_#{table_name}.rb"
  end
  
  def migration_data
<<RUBY
      # Authenticatable
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :password_salt, null: false
      t.string :reset_password_key
      t.datetime :reset_password_key_expired_at
      # Confirmable
      #t.datetime :confirmed_at
      #t.string :confirmation_key
      #t.datetime :confirmation_key_expired_at
RUBY
  end
end
