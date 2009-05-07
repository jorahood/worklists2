class RenameBoilerNameToBoiler < ActiveRecord::Migration
  def self.up
rename_table :boiler_names, :boilers
  end

  def self.down
    rename_table :boilers, :boiler_names
  end
end
