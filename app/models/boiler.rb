class Boiler < ActiveRecord::Base

  hobo_model # Don't put anything above this

  include XmlUtilities
  
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

  def appearances_in_unarchived_docs
    appearances_in_docs.unarchived
  end

  #FIXME: Hobo - if I put the #count method in the view, Hobo needlessly 
  #retrieves the entire doc record as well as the count when checking visibility through the doc model.
  #Perhaps a :select option on the named_scope could prevent this by preventing it from retrieving any doc attrs.
  def count_appearances_in_unarchived_docs
    appearances_in_unarchived_docs.count
  end

  def count_appearances_in_unarchived_docs_ordered

  end

  named_scope :unarchived, :include => :doc, :conditions => "#{Doc.table_name}.visibility <> 3"

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
