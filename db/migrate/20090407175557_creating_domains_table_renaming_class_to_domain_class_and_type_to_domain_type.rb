class CreatingDomainsTableRenamingClassToDomainClassAndTypeToDomainType < ActiveRecord::Migration
  def self.up
    create_table :domains do |t|
      t.string :domain
      t.string :domain_class
      t.string :domain_type
      t.string :description
      t.string :visible, :limit => 512
      t.string :accessible, :limit => 512
      t.string :audience, :limit => 512
    end
  end

  def self.down
    drop_table :domains
  end
end
