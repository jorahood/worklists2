class UsedBoiler < ActiveRecord::Base

  hobo_model # Don't put anything above this

  set_table_name :boilerusage
  belongs_to :doc, :foreign_key => 'fromid'
  belongs_to :doc_as_boiler,
     :class_name => 'Boiler',
     :foreign_key => 'boiler'

  def self.import_from_bell
    true
  end

  named_scope :by_total_usages, :select => "*, COUNT(*) AS total_usages", :group => 'boiler'
  named_scope :by_total_usages_asc, :select => "*, COUNT(*) AS total_usages", :group => 'boiler', :order => 'total_usages ASC'
  named_scope :by_total_usages_desc, :select => "*, COUNT(*) AS total_usages", :group => 'boiler', :order => 'total_usages DESC'

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
