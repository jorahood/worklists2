class NameUniqueConstraint < ActiveRecord::Migration

  def self.up
    add_index :docs, :name, :unique => true
  end

  def self.down
    remove_index :docs, :name
  end
end
