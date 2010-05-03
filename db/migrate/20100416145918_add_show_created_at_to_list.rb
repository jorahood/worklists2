class AddShowCreatedAtToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :show_created_at, :boolean, :default => true
  end

  def self.down
    remove_column :lists, :show_created_at
  end
end
