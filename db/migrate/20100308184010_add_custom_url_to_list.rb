class AddCustomUrlToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :custom_url, :string
  end

  def self.down
    remove_column :lists, :custom_url
  end
end
