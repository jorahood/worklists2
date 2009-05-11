class Boiler < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
  end

  set_table_name :documentnames

  set_search_columns nil
  set_primary_key :name
  
  belongs_to :doc, :foreign_key => 'docid'

  has_many :usages, :foreign_key => 'boiler', :class_name => 'UsedBoiler'
  has_many :appearances_in_docs,
    :through => :usages,
    :source => :doc 

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
