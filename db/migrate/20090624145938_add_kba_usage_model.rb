class AddKbaUsageModel < ActiveRecord::Migration
  def self.up
    create_table :kba_usage, :primary_key => [:docid, :kba] do |t|
      t.string :docid, :limit => 4
      t.string :kba, :limit => 4
    end
  end

  def self.down
    drop_table :kba_usage
  end
end
