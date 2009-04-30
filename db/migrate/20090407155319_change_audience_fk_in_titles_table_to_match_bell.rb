class ChangeAudienceFkInTitlesTableToMatchBell < ActiveRecord::Migration
  def self.up
    rename_column :titles, :audience_id, :audience
  end

  def self.down
    rename_column :titles, :audience, :audience_id
  end
end
