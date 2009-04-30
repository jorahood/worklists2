class ListBelongsToAudienceNameFk < ActiveRecord::Migration
  def self.up
    add_column :lists, :audience_name, :string
  end

  def self.down
    remove_column :lists, :audience_name
  end
end
