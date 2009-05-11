class Title < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title :html
  end

  set_table_name :titlecache
  set_search_columns nil

  belongs_to :doc, :foreign_key => 'docid'
  belongs_to :audience, :foreign_key => 'audience'
#  set_primary_keys :doc_id, :audience_id
  

  def self.import_from_bell
    true
  end

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
