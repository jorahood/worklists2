class Domain < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    id :string, :name => true
    domain_class :string
    domain_type :string
    description :string
    visible :string, :limit => 512
    accessible :string, :limit => 512
    audience :string, :limit => 512
  end

  set_search_columns nil

  has_many :domained_docs
  has_many :docs, :through => :domained_docs

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
