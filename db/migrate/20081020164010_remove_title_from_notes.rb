class RemoveTitleFromNotes < ActiveRecord::Migration
  def self.up
    remove_column :notes, :title
  end

  def self.down
    add_column :notes, :title, :string
  end
end
