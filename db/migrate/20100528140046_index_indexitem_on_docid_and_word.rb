class IndexIndexitemOnDocidAndWord < ActiveRecord::Migration
  def self.up
    add_index :indexitem, :docid
    add_index :indexitem, :word
  end

  def self.down
    remove_index :indexitem, :docid
    remove_index :indexitem, :word
  end
end
