class CreateUsedBoilerModel < ActiveRecord::Migration
  def self.up
    create_table :used_boilers, :id => false do |t|
      t.string  :boiler_name
      t.string :doc_id
    end
  end

  def self.down
    drop_table :used_boilers
  end
end
