class AddHotitemToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :hotitem_id, :string
  end

  def self.down
    remove_column :searches, :hotitem_id
  end
end
