class V1ListedDoc < Worklists1

  hobo_model # Don't put anything above this

  fields do
    searchdate   :datetime
    modifieddate :datetime
    category     :string
    notes        :text
    editornotes  :text
    done         :boolean
  end

  set_table_name :docs_in_lists
  set_primary_keys :listKey, :docKey
  
  belongs_to :v1_list,
    :foreign_key => :listKey
  belongs_to :v1_doc,
    :foreign_key => :docKey
  
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
