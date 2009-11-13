class AddShowOptionsToLists < ActiveRecord::Migration
  def self.up
    add_column :lists, :show_approveddate, :boolean, :default => true
    add_column :lists, :show_author, :boolean
    add_column :lists, :show_boilers, :boolean
    add_column :lists, :show_birthdate, :boolean
    add_column :lists, :show_doc_id, :boolean, :default => true
    add_column :lists, :show_domains, :boolean, :default => true
    add_column :lists, :show_expirations, :boolean
    add_column :lists, :show_hotitems, :boolean
    add_column :lists, :show_importance, :boolean
    add_column :lists, :show_kbas, :boolean
    add_column :lists, :show_kba_bys, :boolean
    add_column :lists, :show_modifieddate, :boolean, :default => true
    add_column :lists, :show_notes, :boolean, :default => true
    add_column :lists, :show_owner, :boolean, :default => true
    add_column :lists, :show_refs, :boolean
    add_column :lists, :show_refbys, :boolean
    add_column :lists, :show_referenced_boilers, :boolean
    add_column :lists, :show_resources, :boolean
    add_column :lists, :show_status, :boolean
#    add_column :lists, :show_tags, :boolean, :default => true
    add_column :lists, :show_titles, :boolean, :default => true
    add_column :lists, :show_visibility, :boolean, :default => true
    add_column :lists, :show_volatility, :boolean
    add_column :lists, :show_xtras, :boolean
  end

  def self.down
    remove_column :lists, :show_approveddate
    remove_column :lists, :show_author
    remove_column :lists, :show_boilers
    remove_column :lists, :show_birthdate
    remove_column :lists, :show_doc_id
    remove_column :lists, :show_domains
    remove_column :lists, :show_expirations
    remove_column :lists, :show_hotitems
    remove_column :lists, :show_importance
    remove_column :lists, :show_kbas
    remove_column :lists, :show_kba_bys
    remove_column :lists, :show_modifieddate
    remove_column :lists, :show_notes
    remove_column :lists, :show_owner
    remove_column :lists, :show_refs
    remove_column :lists, :show_refbys
    remove_column :lists, :show_referenced_boilers
    remove_column :lists, :show_resources
    remove_column :lists, :show_status
#    remove_column :lists, :show_tags
    remove_column :lists, :show_titles
    remove_column :lists, :show_visibility
    remove_column :lists, :show_volatility
    remove_column :lists, :show_xtras
  end
end
