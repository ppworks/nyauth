class AddNyauthTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    change_table(:<%= table_name %>) do |t|
<%= migration_data -%>
    end

    add_index :<%= table_name %>, :email, unique: true
    add_index :<%= table_name %>, :reset_password_key, unique: true
    # Confirmable
    #add_index :<%= table_name %>, :confirmation_key, unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
