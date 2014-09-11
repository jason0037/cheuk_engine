class CreateEventLogs < ActiveRecord::Migration
  def change
    create_table :event_logs do |t|
      t.integer :role_id
      t.string :username
      t.integer :task_id
      t.string :operation
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
