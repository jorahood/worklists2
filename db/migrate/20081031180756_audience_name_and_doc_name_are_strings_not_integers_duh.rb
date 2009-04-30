class AudienceNameAndDocNameAreStringsNotIntegersDuh < ActiveRecord::Migration
  def self.up
    change_column :titles, :doc_name, :string
    change_column :titles, :audience_name, :string
  end

  def self.down
    change_column :titles, :doc_name, :integer
    change_column :titles, :audience_name, :integer
  end
end
