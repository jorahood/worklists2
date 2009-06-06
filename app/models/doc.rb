class Doc < ActiveRecord::Base

  hobo_model # Don't put anything above this

  include XmlUtilities

  fields do
    id :string, :name => true #unique_index
    birthdate :date
    modifieddate :datetime
    approveddate :date
  end

  #don't display the fks
  never_show :importance, :visibility, :volatility, :status, :author, :owner
  set_table_name :document
  set_search_columns :id

  #Changing the association names to be different from the foreign
  # keys to help keep Hobo from getting confused
  belongs_to :importance_assoc, 
    :class_name => 'Importance',
    :foreign_key => 'importance'
  belongs_to :visibility_assoc,
    :class_name => 'Visibility',
    :foreign_key => 'visibility'
  belongs_to :volatility_assoc,
    :class_name => 'Volatility',
    :foreign_key => 'volatility'
  belongs_to :status_assoc,
    :class_name => 'Status',
    :foreign_key => 'status'
  belongs_to :author_assoc,
    :class_name => 'Kbuser',
    :foreign_key => 'author' 
  belongs_to :owner_assoc,
    :class_name => 'Kbuser',
    :foreign_key => 'owner'
    
  has_many :listed_docs,
    :dependent=>:destroy
  has_many :lists, 
    :through => :listed_docs,
    :accessible => true
  has_many :domained_docs,
    :foreign_key => 'id'
  has_many :domains,
    :through => :domained_docs,
    :accessible => true
  has_many :titles,
    :foreign_key => 'docid'
  has_many :expirations,
    :foreign_key => 'id' # FIXME - should be has_one but hobo doesn't support has_one yet
  has_many :hotitems,
    :foreign_key => 'id'
  has_many :kbusers_as_resources,
    :class_name => 'Kbresource',
    :foreign_key => 'id'
  has_many :resources, 
    :through => :kbusers_as_resources,
    :source => :kbuser
  has_many :boilers,
    :foreign_key => 'docid' # FIXME - should be has_one but hobo doesn't support has_one yet
  has_many :boiler_usages,
    :foreign_key => 'fromid'
  has_many :referenced_boilers,
    :through => :boiler_usages,
    :source => :doc_as_boiler

  def self.import_from_bell
    true
  end

  named_scope :unarchived, :conditions => 'visibility > 3'

def default_title
  titles.default.first
end

def docid
  id
end
  # --- Permissions --- #

  def create_permitted?
    return true if acting_user.administrator?

    false
  end

  def update_permitted?
    return true if acting_user.administrator?

    false
  end

  def destroy_permitted?
    return true if acting_user.administrator?

    false
  end

  def view_permitted?(field)
    true
  end

end
