class CreateCustomerInfoTasks < ActiveRecord::Migration
  def change
    create_table :customer_info_tasks do |t|
      t.string :state
      t.integer :role_id
      t.string :username

      t.timestamps
    end
  end
end
