require 'rails_helper'
require 'generators/nyauth/nyauth_generator'

describe Nyauth::NyauthGenerator, type: :generator do
  destination ::File.expand_path('../tmp/', __FILE__)

  before do
    prepare_destination
    run_generator %w(user)
  end

  describe 'rails g nyauth User' do
    it 'creates a test migration' do
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /t.string :email, null: false/
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /t.string :password_digest, null: false/
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /t.string :password_salt, null: false/
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /t.string :reset_password_key/
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /t.datetime :reset_password_key_expired_at/
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /#t.datetime :confirmed_at/
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /#t.string :confirmation_key/
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /#t.datetime :confirmation_key_expired_at/
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /add_index :users, :email, unique: true/
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /add_index :users, :reset_password_key, unique: true/
      assert_migration 'db/migrate/add_nyauth_to_users.rb', /#add_index :users, :confirmation_key, unique: true/
    end
  end
end
