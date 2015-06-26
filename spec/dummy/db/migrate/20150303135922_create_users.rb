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
