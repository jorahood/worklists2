class Search < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    title_search :string
    approveddate :date
    modifieddate :date #leaving this a date for now to simplify equality-searching and because Hobo can't deal with nil datetimes yet
    birthdate :date
    expiredate :date
    timestamps
  end

  belongs_to :importance
  belongs_to :visibility
  belongs_to :volatility
  belongs_to :status
  belongs_to :author,
    :class_name => 'Kbuser',
    :foreign_key => :author_id
  belongs_to :owner,
    :class_name => 'Kbuser',
    :foreign_key => :owner_id
  belongs_to :resource,
    :class_name => 'Kbuser',
    :foreign_key => :resource_id
  belongs_to :boiler

  has_many :domain_searches
  has_many :domains,
    :through => :domain_searches,
    :accessible => true


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
