class HoboMigration7 < ActiveRecord::Migration
  def self.up
    rename_table :docs_in_lists, :listed_docs
    
  end

  def self.down
    rename_table :listed_docs, :docs_in_lists
  end
end
