class CreateWorkshopDocumentAssets < ActiveRecord::Migration
  def self.up
    create_table :documentasset do |t|
      t.string :document
      t.string :label
    end
  end

  def self.down
    drop_table :documentasset
  end
end
