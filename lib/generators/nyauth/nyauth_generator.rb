require 'rails/generators/active_record'

class Nyauth::NyauthGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path("../templates", __FILE__)
  
  def copy_nyauth_migration
    migration_template "migration.rb", "db/migrate/add_nyauth_to_#{table_name}.rb"
  end
  
  def inject_devise_content
    content = model_contents

    class_path = if namespaced?
      class_name.to_s.split("::")
    else
      [class_name]
    end

    indent_depth = class_path.size - 1
    content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"

    inject_into_class(model_path, class_path.last, content) if model_exists?
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
  
  def model_contents
<<RUBY
  include Nyauth::Authenticatable
  #include Nyauth::Confirmable
RUBY
  end
  
  private

  def model_exists?
    File.exists?(File.join(destination_root, model_path))
  end
  
  def model_path
    @model_path ||= File.join("app", "models", "#{file_path}.rb")
  end
end
