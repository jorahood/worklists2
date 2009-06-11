class Search < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    title_search :string
    approveddate_search :date
    modifieddate_search :datetime
    birthdate_search :date
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
