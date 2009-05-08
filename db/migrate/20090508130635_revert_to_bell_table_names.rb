class RevertToBellTableNames < ActiveRecord::Migration
  def self.up
    rename_table :audiences, :titleaudience
    rename_table :boilers, :documentnames
    rename_table :docs, :document
    rename_table :domained_docs, :documentdomain
    rename_table :domains, :domainlist
    rename_table :expirations, :expire
    rename_table :hotitems, :hotitem
    rename_table :importances, :importance
    rename_table :kbresources, :kbresource
    rename_table :kbusers, :kbuser
    rename_table :statuses, :status
    rename_table :titles, :titlecache
    rename_table :used_boilers, :boilerusage
    rename_table :visibilities, :visibility
    rename_table :volatilities, :volatility
  end

  def self.down
    rename_table :titleaudience, :audiences
    rename_table :documentnames, :boilers
    rename_table :document, :docs
    rename_table :documentdomain, :domained_docs
    rename_table :domainlist, :domains
    rename_table :expire, :expirations
    rename_table :hotitem, :hotitems
    rename_table :importance, :importances
    rename_table :kbresource, :kbresources
    rename_table :kbuser, :kbusers
    rename_table :status, :statuses
    rename_table :titlecache, :titles
    rename_table :boilerusage, :used_boilers
    rename_table :visibility, :visibilities
    rename_table :volatility, :volatilities
  end
end
