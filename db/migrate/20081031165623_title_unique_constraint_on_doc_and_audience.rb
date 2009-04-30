class TitleUniqueConstraintOnDocAndAudience < ActiveRecord::Migration
  def self.up
    add_index :titles, [:doc_name, :audience_name], :unique => true
  end

  def self.down
    remove_index :titles, [:doc_name, :audience_name]
  end
end
