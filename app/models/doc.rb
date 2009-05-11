class Doc < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    id :string, :name => true #unique_index
    birthdate :date
    modifieddate :datetime
    approveddate :date
  end

  set_table_name :document
  set_search_columns :id

  belongs_to :importance, :foreign_key => 'importance'
  belongs_to :visibility, :foreign_key => 'visibility'
  belongs_to :volatility, :foreign_key => 'volatility'
  belongs_to :status, :foreign_key => 'status'
  belongs_to :author,
    :class_name => 'Kbuser',
    :foreign_key => 'author' 
  belongs_to :owner,
    :class_name => 'Kbuser',
    :foreign_key => 'owner'
    
  has_many :listed_docs, :dependent=>:destroy
  has_many :lists, 
    :through => :listed_docs,
    :accessible => true
  has_many :domained_docs, :foreign_key => 'id'
  has_many :domains, :through => :domained_docs
  has_many :titles, :foreign_key => 'docid'
  has_many :expirations, :foreign_key => 'id' # FIXME - should be has_one but hobo doesn't support has_one yet
  has_many :hotitems, :foreign_key => 'id'
  has_many :kbusers_as_resources,
    :class_name => 'Kbresource', :foreign_key => 'id'
  has_many :resources, 
    :through => :kbusers_as_resources,
    :source => :kbuser
  has_many :boilers, :foreign_key => 'docid' # FIXME - should be has_one but hobo doesn't support has_one yet
  has_many :used_boilers, :foreign_key => 'fromid'
  has_many :boiler_usages,
    :through => :used_boilers,
    :source => :boiler

  def self.import_from_bell
    true
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
