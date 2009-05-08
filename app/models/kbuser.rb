class Kbuser < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    id    :string, :name => true
    lastname    :string
    firstname   :string
    email       :string
    password :string
    worknumber  :string
    homenumber  :string
    status      :string
    pagernumber :string
  end

  set_table_name :kbuser
  set_search_columns nil

  has_many :kbresource_roles, :class_name => 'Kbresource'
  has_many :resourced_docs, 
    :through => :kbresource_roles,
    :source => :doc
  has_many :authored_docs, 
    :class_name => 'Doc',
    :foreign_key => 'author_id'
  has_many :owned_docs,
    :class_name => 'Doc',
    :foreign_key => 'owner_id'
  
  never_show :worknumber, :homenumber, :pagernumber, :password

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
