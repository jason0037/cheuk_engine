class AddMaxServiceToUsers < ActiveRecord::Migration
  def up
    add_column :roles_users, :max_service, :integer,:default=>0
  end

  def down
     remove_column :roles_users, :max_service
  end
end
