class AddListsShowWorkstateAttr < ActiveRecord::Migration
  def self.up
    add_column :lists, :show_workstate, :boolean, :default => true
  end

  def self.down
    remove_column :lists, :show_workstate
  end
end
