class IndexHotitemOnId < ActiveRecord::Migration
  def self.up
    add_index :hotitem, :id
  end

  def self.down
    remove_index :hotitem, :id
  end
end
