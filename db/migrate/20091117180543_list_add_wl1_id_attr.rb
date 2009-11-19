class ListAddWl1IdAttr < ActiveRecord::Migration
  def self.up
    add_column :lists, :wl1_import, :integer
  end

  def self.down
    remove_column :lists, :wl1_import
  end
end
