class BirthAndApprovedToDateOnly < ActiveRecord::Migration
  def self.up
    change_column :docs, :birthdate, :date
    change_column :docs, :approveddate, :date
  end

  def self.down
    change_column :docs, :birthdate, :datetime
    change_column :docs, :approveddate, :datetime
  end
end
