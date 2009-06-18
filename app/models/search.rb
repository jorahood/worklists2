class Search < ActiveRecord::Base

  hobo_model # Don't put anything above this

  DateComparison = HoboFields::EnumString.for(:is, :before, :after)

  fields do
    name :string
    title_search :string
    xtra_search :string
    approveddate :date
    adate_comp DateComparison
    modifieddate :date
    mdate_comp DateComparison
    birthdate :date
    bdate_comp DateComparison
    expiredate :date
    edate_comp DateComparison
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
  belongs_to :hotitem

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
