class GoingBackToUsingNonintegerIdKeys_forAudience < ActiveRecord::Migration
  def self.up
    rename_column :audiences, :name, :id
    
    rename_column :lists, :audience_name, :audience_id
    
    rename_column :titles, :audience_name, :audience_id
  end

  def self.down
    rename_column :audiences, :id, :name
    
    rename_column :lists, :audience_id, :audience_name
    
    rename_column :titles, :audience_id, :audience_name
  end
end
