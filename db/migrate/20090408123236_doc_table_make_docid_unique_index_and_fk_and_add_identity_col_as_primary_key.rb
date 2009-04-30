class DocTableMakeDocidUniqueIndexAndFkAndAddIdentityColAsPrimaryKey < ActiveRecord::Migration
  def self.up
    change_table :docs do |t|
  #    t.rename :id, :docid
      t.integer :id, :primary_key => true
      t.index :docid, :unique => true
    end
    
  end

  def self.down
    change_table :docs do |t|
      t.remove_index :docid
      t.remove :id
      t.rename :docid, :id
    end
  end
end