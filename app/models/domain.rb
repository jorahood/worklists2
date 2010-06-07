class Domain < Kb3

  hobo_model # Don't put anything above this

  fields do
    domain :string, :name => true
    # can't declare 'class' as a field but Rails will still read the class column from
    # the db so it will be available as domain[:class] or domain.read_attribute[:class]
    type :string
    description :string
    visible :string, :limit => 512
    accessible :string, :limit => 512
    audience :string, :limit => 512
  end

  #to allow a column named 'class' : http://www.ruby-forum.com/topic/138433
  class << self
    def instance_method_already_implemented?(method_name)
      return true if method_name == 'class'
      super
    end
  end

  # 'type' is a column name which Rails looks for when doing STI, and
  # setting inheritance_column to nil stops Rails from flipping out
  self.inheritance_column = nil
  set_table_name :domainlist
  
  set_search_columns nil

  has_many :domained_docs, :foreign_key => 'domain'
  has_many :docs, :through => :domained_docs

  has_many :domain_searches
  
  set_primary_key :domain

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
