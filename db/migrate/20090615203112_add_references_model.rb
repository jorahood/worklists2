class AddReferencesModel < ActiveRecord::Migration
  def self.up
    create_table :references, :id => false do |t|
      t.string :fromid
      t.string :toid
    end
    execute("ALTER TABLE `references` ADD PRIMARY KEY (`fromid`, `toid`)")
  end

  def self.down
    drop_table :references
  end
end
