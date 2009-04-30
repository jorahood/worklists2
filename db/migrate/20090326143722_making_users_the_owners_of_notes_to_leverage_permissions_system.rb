class MakingUsersTheOwnersOfNotesToLeveragePermissionsSystem < ActiveRecord::Migration
  def self.up
    rename_column :notes, :user_id, :owner_id
  end

  def self.down
    rename_column :notes, :owner_id, :user_id
  end
end
