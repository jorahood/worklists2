class AddDateComparisonOperatorsToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :approveddate_is, :string
    add_column :searches, :birthdate_is, :string
    add_column :searches, :modifieddate_is, :string
    add_column :searches, :expiredate_is, :string
  end

  def self.down
    remove_column :searches, :expiredate_is
    remove_column :searches, :modifieddate_is
    remove_column :searches, :birthdate_is
    remove_column :searches, :approveddate_is
  end
end
