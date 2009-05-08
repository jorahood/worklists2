class Domain < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    domain :string, :name => true
    domain_class :string
    type :string
    description :string
    visible :string, :limit => 512
    accessible :string, :limit => 512
    audience :string, :limit => 512
  end

  # 'type' is a column name which Rails looks for when doing STI, and
  # setting inheritance_column to nil stops Rails from flipping out
  self.inheritance_column = nil
  set_table_name :domainlist
  
  set_search_columns nil

  has_many :domained_docs, :foreign_key => 'domain'
  has_many :docs, :through => :domained_docs

  set_primary_key :domain
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
