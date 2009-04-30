class SetDefaultAudienceForLists < ActiveRecord::Migration
  def self.up
    remove_column :lists, :audience_name
    add_column :lists, :audience_name, :string, :default => 'default'
  end

  def self.down
    remove_column :lists, :audience_name
    add_column :lists, :audience_name, :string
  end
end
