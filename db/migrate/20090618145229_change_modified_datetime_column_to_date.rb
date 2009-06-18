class ChangeModifiedDatetimeColumnToDate < ActiveRecord::Migration
  def self.up
    change_column :document, :modifieddate, :date
    change_column :searches, :modifieddate, :date
  end

  def self.down
    change_column :document, :modifieddate, :datetime
    change_column :searches, :modifieddate, :datetime
  end
end
