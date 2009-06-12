class AddExpireDateToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :expiredate, :date
  end

  def self.down
    remove_column :searches, :expiredate
  end
end
