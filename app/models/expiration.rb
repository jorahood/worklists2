class Expiration < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    expiredate   :date
    explanation :string
  end

  set_table_name :expire
  set_search_columns nil

  set_primary_key :id # referring to the doc below

  belongs_to :doc, :foreign_key => 'id'

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

  def name
    "#{expiredate.to_s(:long)}: #{explanation}"
  end
end
