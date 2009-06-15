class AddXtrasToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :xtra_search, :string
    add_index :xtra, :id
  end

  def self.down
    remove_column :searches, :xtra_search
    remove_index :xtra, :id
  end
end
