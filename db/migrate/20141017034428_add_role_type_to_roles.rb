class AddRoleTypeToRoles < ActiveRecord::Migration
  def up
    add_column :roles, :role_type, :integer,:default=>0
  end

  def down
     remove_column :roles, :role_type
  end
end
