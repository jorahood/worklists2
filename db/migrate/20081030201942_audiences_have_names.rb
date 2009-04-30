class AudiencesHaveNames < ActiveRecord::Migration
  def self.up
    rename_column :audiences, :audience, :name
  end

  def self.down
    rename_column :audiences, :name, :audience
  end
end
