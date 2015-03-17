class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :password_salt, null: false

      t.timestamps null: false
    end
    add_index :admins, :email, unique: true
  end
end
