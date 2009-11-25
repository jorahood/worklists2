class ListAddWl1Clone < ActiveRecord::Migration
  def self.up
    add_column :lists, :wl1_clone, :integer
  end

  def self.down
    remove_column :lists, :wl1_clone, :integer
  end
end
