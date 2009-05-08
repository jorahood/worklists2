class RevertToBellColumnNames < ActiveRecord::Migration
  def self.up
    rename_column :titleaudience, :id, :audience
    rename_column :documentnames, :doc_id, :docid
    change_table(:document) do |t|
      t.rename :author_id, :author
      t.rename :importance_id, :importance
      t.rename :owner_id, :owner
      t.rename :status_id, :status
      t.rename :visibility_id, :visibility
      t.rename :volatility_id, :volatility
    end
    rename_column :documentdomain, :doc_id, :id
    rename_column :documentdomain, :domain_id, :domain
    rename_column :domainlist, :id, :domain
    rename_column :domainlist, :domain_type, :type
    rename_column :expire, :doc_id, :id
    rename_column :expire, :date, :expiredate
    rename_column :expire, :reason, :explanation
    rename_column :hotitem, :doc_id, :id
    rename_column :hotitem, :name, :hotitem
    rename_column :importance, :name, :importance
    rename_column :importance, :id, :rank
    rename_column :kbresource, :doc_id, :id
    rename_column :kbresource, :kbuser_id, :username
    rename_column :kbuser, :id, :username
    rename_column :status, :name, :status
    rename_column :status, :id, :rank
    rename_column :titlecache, :audience_id, :audience
    rename_column :titlecache, :doc_id, :docid
    rename_column :boilerusage, :doc_id, :fromid
    rename_column :boilerusage, :boiler_name, :boiler
    rename_column :visibility, :name, :visibility
    rename_column :visibility, :id, :rank
    rename_column :volatility, :name, :volatility
    rename_column :volatility, :id, :rank
  end

  def self.down
    rename_column :titleaudience, :audience, :id
    rename_column :documentnames, :docid, :doc_id
    change_table(:document) do |t|
      t.rename :author,:author_id
      t.rename :importance, :importance_id
      t.rename :owner, :owner_id
      t.rename :status, :status_id
      t.rename :visibility, :visibility_id
      t.rename :volatility, :volatility_id
    end
    rename_column :documentdomain, :id, :doc_id
    rename_column :documentdomain, :domain, :domain_id
    rename_column :domainlist, :domain, :id
    rename_column :domainlist, :type, :domain_type
    rename_column :expire, :id, :doc_id
    rename_column :expire, :expiredate, :date
    rename_column :expire, :explanation, :reason
    rename_column :hotitem, :id, :doc_id
    rename_column :hotitem, :hotitem, :name
    rename_column :importance, :importance, :name
    rename_column :importance, :rank, :id
    rename_column :kbresource, :id, :doc_id
    rename_column :kbresource, :username, :kbuser_id
    rename_column :kbuser, :username, :id
    rename_column :status, :status, :name
    rename_column :status, :rank, :id
    rename_column :titlecache, :audience, :audience_id
    rename_column :titlecache, :docid, :doc_id
    rename_column :boilerusage, :doc_id, :fromid
    rename_column :boilerusage, :boiler_name, :boiler
    rename_column :visibility, :visibility, :name
    rename_column :visibility, :rank, :id
    rename_column :volatility, :volatility, :name
    rename_column :volatility, :rank, :id
  end
end
