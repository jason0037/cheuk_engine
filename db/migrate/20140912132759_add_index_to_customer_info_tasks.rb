class AddIndexToCustomerInfoTasks < ActiveRecord::Migration
  def up
    add_column :customer_info_tasks, :index, :integer,:default=>0
    add_column :event_logs, :index, :integer
  end

  def down
     remove_column :customer_info_tasks, :index
     remove_column :event_logs, :index
  end
end
