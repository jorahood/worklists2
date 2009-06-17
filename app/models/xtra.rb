class Xtra < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    term   :string, :name => true
    weight :integer
  end

#  set_primary_keys :term, :id
  set_table_name :xtra
  set_search_columns nil

  belongs_to :doc,
    :foreign_key => 'id'

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
