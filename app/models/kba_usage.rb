class KbaUsage < ActiveRecord::Base

  hobo_model # Don't put anything above this

  set_primary_keys :docid, :kba
  set_search_columns nil
  set_table_name :kba_usage

  belongs_to :doc, :foreign_key => 'docid'
  belongs_to :doc_as_kba,
    :class_name => 'Doc',
    :foreign_key => 'kba'

  def self.import_from_bell
    true
  end


  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
