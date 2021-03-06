class V1List < Worklists1
  
  hobo_model # Don't put anything above this

  fields do
    name       :string
    comments   :text
    kbss       :text
    parameters :text
    total      :integer
    untouched  :integer
    pending    :integer
    completed  :integer
    deleted    :boolean
    inactive   :boolean
    owner      :string
    notify     :string
    createddate :datetime
    modifieddate :datetime
  end

  set_table_name :listdata

  has_many :v1_listed_docs,
    :foreign_key => :listKey
  has_many :v1_docs,
    :through => :v1_listed_docs
  
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
