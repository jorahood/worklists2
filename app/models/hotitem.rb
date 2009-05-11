class Hotitem < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    hotitem :string
  end

  set_table_name :hotitem
  set_search_columns nil

  belongs_to :doc, :foreign_key => 'id'

  set_primary_key :hotitem

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
