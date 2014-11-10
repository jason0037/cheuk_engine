class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks,:options=>"ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
      t.string :task_type
      t.string :state
      t.integer :role_id
      t.string :username
      t.integer :index,:default=>0
      
      t.timestamps
    end
  end
end
