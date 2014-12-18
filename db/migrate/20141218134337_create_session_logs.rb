class CreateSessionLogs < ActiveRecord::Migration
  def change
    create_table :session_logs,:options=>"ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
      t.string :username
      t.timestamps
    end
  end
end
