class StatusVisibilityVolatilityImportanceModels < ActiveRecord::Migration
  def self.up
    create_table :importances, :id => false do |t|
      t.integer :level
      t.string  :name
    end
    
    create_table :statuses, :id => false do |t|
      t.integer :level
      t.string  :name
    end
    
    create_table :visibilities, :id => false do |t|
      t.integer :level
      t.string  :name
    end
    
    create_table :volatilities, :id => false do |t|
      t.integer :level
      t.string  :name
    end
    
    rename_column :docs, :status, :status_level
    rename_column :docs, :visibility, :visibility_level
    rename_column :docs, :volatility, :volatility_level
    rename_column :docs, :importance, :importance_level
  end

  def self.down
    rename_column :docs, :status_level, :status
    rename_column :docs, :visibility_level, :visibility
    rename_column :docs, :volatility_level, :volatility
    rename_column :docs, :importance_level, :importance
    
    drop_table :importances
    drop_table :statuses
    drop_table :visibilities
    drop_table :volatilities
  end
end
