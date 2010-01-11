class V1Doc < Worklists1

  hobo_model # Don't put anything above this

  fields do
    category        :string
    DOCID           :string, :name => true
    TITLE           :string
    APPROVED_DATE   :date
    MODIFIED_DATE   :date
    BIRTH_DATE      :date
    DOMAIN          :string
    OWNER           :string
    AUTHOR          :string
    EXPIRE_DATE     :string
    DIRTY_DOZEN     :integer
    HITS_ALL        :integer
    HITS_IUB        :integer
    HITS_IUBRESHALL :integer
    HITS_IUPUI      :integer
    HITS_OSE        :integer
    REFS            :integer
    REFBYS          :integer
    IMAGE_USAGE     :integer
    SIZE            :integer
    STATUS          :string
    RESOURCE        :string
    IMPORTANCE      :string
    URL_USAGE       :integer
    BOILER_USAGE    :string
    VISIBILITY      :string
    VOLATILITY      :string
    XTRA            :integer
    ALLHITS         :integer
    OSEHITS         :integer
    SAKAIHITS       :integer
    SCHITS          :integer
    TGRID_COREHITS  :integer
    UITSHITS        :integer
    VISIBILEHITS    :integer
    NEWVERSION      :string
    TGRID_ALLHITS   :integer
    TGRIDHITS       :integer
  end

  set_table_name :docdata

  has_many :v1_listed_docs,
    :foreign_key => :docKey
  has_many :v1_lists,
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
