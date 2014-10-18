class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :bpm_attachments do |t|
      t.string :process_type
      t.integer :process_id
      t.integer :index
      t.string :attachment_type
      t.string :content
      
      t.timestamps
    end
  end
end
