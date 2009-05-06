class CreateBoilerName < ActiveRecord::Migration
  def self.up
    create_table :boiler_names do |t|
      t.string  :name
      t.string :doc_id
    end
  end

  def self.down
    drop_table :boiler_names
  end
end
