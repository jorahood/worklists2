class UseAudienceNameAsTitleFk < ActiveRecord::Migration
  def self.up
    rename_column :titles, :audience_id, :audience_name
  end

  def self.down
    rename_column :titles, :audience_name, :audience_id
  end
end
