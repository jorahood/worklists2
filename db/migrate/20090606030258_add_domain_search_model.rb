class AddDomainSearchModel < ActiveRecord::Migration
  def self.up
    create_table :domain_searches do |t|
      t.integer :search_id
      t.string :domain_id
    end
  end

  def self.down
    drop_table :domain_searches
  end
end
