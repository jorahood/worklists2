class AddKeywordComparisonsToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :importance_is, :string
    add_column :searches, :visibility_is, :string
    add_column :searches, :volatility_is, :string
    add_column :searches, :status_is, :string
  end

  def self.down
    remove_column :searches, :status_is
    remove_column :searches, :volatility_is
    remove_column :searches, :visibility_is
    remove_column :searches, :importance_is
  end
end
