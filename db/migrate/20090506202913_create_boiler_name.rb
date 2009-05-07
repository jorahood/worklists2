class CreateBoilerName < ActiveRecord::Migration
  def self.up
    create_table :boiler_names, :id => false do |t|
      t.string  :name
      t.string :doc_id
    end
  end

  def self.down
    drop_table :boiler_names
  end
end
