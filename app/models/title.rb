class Title < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title :html
  end

  set_table_name :titlecache
  set_search_columns nil

  belongs_to :doc,
    :foreign_key => 'docid'
  belongs_to :audience,
    :foreign_key => 'audience'
  set_primary_keys :docid, :audience
  

  def self.import_from_bell
    true
  end

  named_scope :default, :conditions => {:audience => Audience.default}, :limit => 1
  # --- Permissions --- #

  def create_permitted?
    true
  end

  def update_permitted?
    true
  end

  def destroy_permitted?
    true
  end

  def view_permitted?(field)
    true
  end

end
