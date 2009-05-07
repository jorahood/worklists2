class Boiler < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
  end

  set_search_columns nil
  set_primary_key :name
  
  belongs_to :doc

  has_many :usages, :foreign_key => 'boiler_name', :class_name => 'UsedBoiler'
  has_many :appearances_in_docs,
    :through => :usages,
    :source => :doc 

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
