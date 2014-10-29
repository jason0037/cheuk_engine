class CreateGuests < ActiveRecord::Migration
  def change
    create_table :openfire_guests,:options=>"ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
      t.string :status
      t.string :username
      t.string :name
      t.integer :times
      t.integer :reject_times
      t.string :ip
      t.string :area
      t.string :key_words
      t.string :last_visit
      t.string :customer_service
      t.string :last_message
      
      t.timestamps
    end
  end
end
