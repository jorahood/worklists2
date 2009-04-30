class HoboMigration4 < ActiveRecord::Migration
  def self.up
    rename_table :docs_in_list, :docs_in_lists
  end

  def self.down
    rename_table :docs_in_lists, :docs_in_list
  end
end
