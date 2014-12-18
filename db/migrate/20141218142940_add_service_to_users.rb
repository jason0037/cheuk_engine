class AddServiceToUsers < ActiveRecord::Migration
  def up
    add_column :roles_users, :service, :integer,:default=>0
  end

  def down
     remove_column :roles_users, :service
  end
end
