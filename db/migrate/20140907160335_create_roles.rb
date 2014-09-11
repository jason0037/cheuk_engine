class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles,:options => 'ENGINE=innodb DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :key

      t.timestamps
    end
  end
end
