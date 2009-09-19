class Search < ActiveRecord::Base

  hobo_model # Don't put anything above this

  before_save :clear_unneeded_comparison_attrs

  DateComparison = HoboFields::EnumString.for :is, :before, :after, :is_not
  KeywordComparison = HoboFields::EnumString.for :is, :above, :below, :is_not

  fields do
    name :string
    title_search :string
    xtra_search :string
    approveddate_is DateComparison
    approveddate :date
    modifieddate_is DateComparison
    modifieddate :date
    birthdate_is DateComparison
    birthdate :date
    expiredate_is DateComparison
    expiredate :date
    importance_is KeywordComparison
    visibility_is KeywordComparison
    volatility_is KeywordComparison
    status_is KeywordComparison
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
  has_many :lists,
    :accessible => true

  validates_presence_of :name

  def perform
    Doc.apply_scopes(
      :title_search => title_search,
      :xtra_search => xtra_search,
      :"approveddate_#{approveddate_is}" => approveddate,
      :"birthdate_#{birthdate_is}" => birthdate,
      :"expiredate_#{expiredate_is}" => expiredate,
      :"modifieddate_#{modifieddate_is}" => modifieddate,
      :"visibility_#{visibility_is}" => visibility_id,
      :"volatility_#{volatility_is}" => volatility_id,
      :"status_#{status_is}" => status_id,
      :"importance_#{importance_is}" => importance_id,
      :author_is => author,
      :owner_is => owner,
      :with_resource => resource,
      :with_referenced_boiler => boiler,
      :with_hotitem => hotitem,
      :with_domains => domains
    )
  end

  def save_as_list
    
  end

  # --- Permissions --- #

  def create_permitted?
    true
  end

  def update_permitted?
    true
  end

  def destroy_permitted?
    true
  end

  def view_permitted?(field)
    true
  end

  private
  def clear_unneeded_comparison_attrs
    # each date selector and keyword selector (i.e., visibility, volatility, 
    # status, importance) consists of a value object
    # and a comparison (i.e., on, before, & after for dates,
    # equal to, greater than, & less than for keywords).
    # The search model doesn't care if it has one without the other but
    # it will be confusing to users to see just a date or keyword without its
    # comparison, or just a comparison without its date or keyword.
    # The EnumStrings for the comparisons will submit the first value as a param
    # every time so that takes care of a default for comparisons,
    # so I'll clear the comparisons where their
    # associated date or keyword is nil.

    dates = %w{approveddate birthdate expiredate modifieddate}
    dates.each { |date|
      # Clear the comparison so it doesn't appear sans its date
      if !self[date] && self[date + "_is"]
        self[date + "_is"] = nil
      end
    }
    keywords = %w{importance visibility volatility status}
    keywords.each { |keyword|
      # Clear the comparison so it doesn't appear sans its keyword
      if !self[keyword + "_id"] && self[keyword + "_is"]
        self[keyword + "_is"] = nil
      end
    }
  end

end
