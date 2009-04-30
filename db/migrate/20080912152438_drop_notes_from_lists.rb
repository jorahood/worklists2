class DropNotesFromLists < ActiveRecord::Migration
  def self.up
    add_column :lists, :comment, :text
    
    remove_column :notes, :list_id
  end

  def self.down
    remove_column :lists, :comment
    
    add_column :notes, :list_id, :integer
  end
end
