class ListAddShowTags < ActiveRecord::Migration
  def self.up
    add_column :lists, :show_tags, :boolean, :default => true
  end

  def self.down
    remove_column :lists, :show_tags
  end
end
