class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :type
      t.string :state
      t.integer :role_id
      t.string :username
      t.integer :attachment_id
      t.integer :index
      
      t.timestamps
    end
  end
end
