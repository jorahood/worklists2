class AddIndexesToBoilerusageAndDocumentnames < ActiveRecord::Migration
  def self.up
    add_index :boilerusage, :fromid
    add_index :boilerusage, :boiler
    add_index :documentnames, :docid
    add_index :documentnames, :name
  end

  def self.down
    remove_index :boilerusage, :fromid
    remove_index :boilerusage, :boiler
    remove_index :documentnames, :docid
    remove_index :documentnames, :name
  end
end
