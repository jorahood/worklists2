class HoboMigration9 < ActiveRecord::Migration
  def self.up
    change_column :docs, :visibility, :integer, :limit => 4
    change_column :docs, :status, :integer, :limit => 4
    change_column :docs, :importance, :integer, :limit => 4
    change_column :docs, :volatility, :integer, :limit => 4
  end

  def self.down
    change_column :docs, :visibility, :string
    change_column :docs, :status, :string
    change_column :docs, :importance, :string
    change_column :docs, :volatility, :string
  end
end
