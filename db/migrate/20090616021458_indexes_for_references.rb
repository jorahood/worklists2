class IndexesForReferences < ActiveRecord::Migration
  def self.up
    add_index :references, :fromid
    add_index :references, :toid
  end

  def self.down
    drop_index :references, :fromid
    drop_index :references, :toid
  end
end
