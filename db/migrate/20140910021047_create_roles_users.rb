class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table :roles_users do |t|
    	t.integer :role_id
    	t.string :username
    end
  end
end
