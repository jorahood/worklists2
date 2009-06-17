class AddBoilerToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :boiler_id, :string
  end

  def self.down
    remove_column :searches, :boiler_id
  end
end
