class AddServiceToGuests < ActiveRecord::Migration
  def up
    add_column :openfire_guests, :on_service, :integer,:default=>0
  end

  def down
     remove_column :openfire_guests, :on_service
  end
end
