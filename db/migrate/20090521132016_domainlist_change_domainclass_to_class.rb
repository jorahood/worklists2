class DomainlistChangeDomainclassToClass < ActiveRecord::Migration
  def self.up
    rename_column :domainlist, :domain_class, :class
  end

  def self.down
    rename_column :domainlist, :class, :domain_class
  end
end
