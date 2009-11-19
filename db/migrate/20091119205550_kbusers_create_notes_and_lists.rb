class KbusersCreateNotesAndLists < ActiveRecord::Migration
  def self.up
    remove_column :notes, :owner_id
    add_column :notes, :creator_id, :string
    remove_column :lists, :owner_id
    add_column :lists, :creator_id, :string
  end

  def self.down
    add_column :notes, :owner_id, :integer
    remove_column :notes, :creator_id
    add_column :lists, :owner_id, :integer
    remove_column :lists, :creator_id
  end
end
