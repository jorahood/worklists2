class AddIndexesToTitles < ActiveRecord::Migration
  def self.up
    add_index :titlecache, :docid
    add_index :titlecache, :audience
  end

  def self.down
    remove_index :titlecache, :docid
    remove_index :titlecache, :audience
  end
end
