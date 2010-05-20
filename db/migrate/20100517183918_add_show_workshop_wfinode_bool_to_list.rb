class AddShowWorkshopWfinodeBoolToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :show_workshop_wfinodes, :boolean
  end

  def self.down
    remove_column :lists, :show_workshop_wfinodes
  end
end
