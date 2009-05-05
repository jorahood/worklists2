class Doc < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    id :string, :name => true #unique_index
    birthdate :date
    modifieddate :datetime
    approveddate :date
  end

  set_search_columns :id

  belongs_to :importance
  belongs_to :visibility
  belongs_to :volatility
  belongs_to :status
  belongs_to :author,
    :class_name => 'Kbuser',
    :foreign_key => 'author_id' #FIXME - Hobo should be able to figure out the foreign key on its own
  belongs_to :owner,
    :class_name => 'Kbuser',
    :foreign_key => 'owner_id'
    
  has_many :listed_docs, :dependent=>:destroy
  has_many :lists, 
    :through => :listed_docs,
    :accessible => true
  has_many :domained_docs
  has_many :domains, :through => :domained_docs
  has_many :titles
  has_many :expirations
  has_many :hotitems
  has_many :kbusers_as_resources, :class_name => 'Kbresource'
  has_many :resources, 
    :through => :kbusers_as_resources,
    :source => :kbuser

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
