class Audience < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    audience  :string, :name => true
    description :string
  end

  set_table_name :titleaudience
  set_search_columns nil

  set_primary_key :audience
  
  has_many :titles, :foreign_key => 'audience'
  has_many :lists, :foreign_key => 'audience'

  def self.import_from_bell
    true
  end
  
  # --- Permissions --- #

  def create_permitted?
    false
  end

  def update_permitted?
    false
  end

  def destroy_permitted?
    false
  end

  def view_permitted?(field)
    true
  end

end
