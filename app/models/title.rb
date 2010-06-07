class Title < Kb3

  hobo_model # Don't put anything above this

  fields do
    title :html
  end

  set_table_name :titlecache
  set_search_columns nil

  belongs_to :doc,
    :foreign_key => 'docid'
  belongs_to :audience,
    :foreign_key => 'audience'

   # the fields declaration above interferes with composite primary keys'
   # overriding the primary_key method to return the array set by
   # set_primary_keys, setting it to 'id', which causes ar_extensions to fail to
   # import titles. I'm using the fact that set_primary_key can also take
   # a block as argument and will return the value of the block to hack
   # around this incompatibility.
  set_primary_key {primary_keys}
  set_primary_keys :docid, :audience

  def self.import_from_bell
    true
  end

  named_scope :default, :conditions => {:audience => Audience.default}, :limit => 1
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

end
