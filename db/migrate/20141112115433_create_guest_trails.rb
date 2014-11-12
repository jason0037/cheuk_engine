class CreateGuestTrails < ActiveRecord::Migration
  def change
    create_table :guest_trails,:options=>"ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
      t.string :username
      t.string :ip
      t.string :page_path
      t.string :time_at
            
      t.timestamps
    end
  end
end
