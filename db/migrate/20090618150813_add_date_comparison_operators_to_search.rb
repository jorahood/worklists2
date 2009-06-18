class AddDateComparisonOperatorsToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :adate_comp, :string
    add_column :searches, :bdate_comp, :string
    add_column :searches, :mdate_comp, :string
    add_column :searches, :edate_comp, :string
  end

  def self.down
    remove_column :searches, :edate_comp
    remove_column :searches, :mdate_comp
    remove_column :searches, :bdate_comp
    remove_column :searches, :adate_comp
  end
end
