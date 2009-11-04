class Doc < ActiveRecord::Base

  hobo_model # Don't put anything above this

  include XmlUtilities

  fields do
    id :string, :name => true #unique_index
    birthdate :date
    modifieddate :date
    approveddate :date
  end

  #don't display the fks
#  never_show :importance, :visibility, :volatility, :status, :author, :owner
  set_table_name :document
  set_search_columns :id

  #Changing the association names to be different from the foreign
  # keys to help keep Hobo from getting confused
  belongs_to :importance_assoc, 
    :class_name => 'Importance',
    :foreign_key => 'importance'
  belongs_to :visibility_assoc,
    :class_name => 'Visibility',
    :foreign_key => 'visibility'
  belongs_to :volatility_assoc,
    :class_name => 'Volatility',
    :foreign_key => 'volatility'
  belongs_to :status_assoc,
    :class_name => 'Status',
    :foreign_key => 'status'
  belongs_to :author_assoc,
    :class_name => 'Kbuser',
    :foreign_key => 'author' 
  belongs_to :owner_assoc,
    :class_name => 'Kbuser',
    :foreign_key => 'owner'
    
  has_many :listed_docs,
    :dependent=>:destroy
  has_many :lists, 
    :through => :listed_docs,
    :accessible => true
  has_many :domained_docs,
    :foreign_key => 'id'
  has_many :domains,
    :through => :domained_docs,
    :accessible => true
  has_many :titles,
    :foreign_key => 'docid'
  has_many :expirations,
    :foreign_key => 'id' # FIXME - should be has_one but hobo doesn't support has_one yet
  has_many :hotitems,
    :foreign_key => 'id'
  has_many :kbusers_as_resources,
    :class_name => 'Kbresource',
    :foreign_key => 'id'
  has_many :resources, 
    :through => :kbusers_as_resources,
    :source => :kbuser
  has_many :boilers,
    :foreign_key => 'docid' # FIXME - should be has_one but hobo doesn't support has_one yet
  has_many :boiler_usages,
    :foreign_key => 'fromid'
  has_many :referenced_boilers,
    :through => :boiler_usages,
    :source => :doc_as_boiler
  has_many :xtras,
    :foreign_key => 'id'
  has_many :refs,
    :class_name => 'Reference',
    :foreign_key => 'fromid'
  has_many :refbys,
    :class_name => 'Reference',
    :foreign_key => 'toid'
  has_many :kbas,
    :class_name => 'KbaUsage',
    :foreign_key => 'docid'
  has_many :kba_bys,
    :class_name => 'KbaUsage',
    :foreign_key => 'kba'
  has_many :docid_searches,
    :foreign_key => 'doc_id'
  has_many :searches,
    :through => :docid_searches
  has_one :default_title,
    :class_name => 'Title',
    :foreign_key => 'docid',
    :conditions => ["#{Title.table_name}.audience = ?", "default"]

  def self.import_from_bell
    true
  end

  named_scope :unarchived,
    :conditions => "#{Doc.table_name}.visibility > 3"

  named_scope :title_search, lambda { |search|
    {:joins => :titles,
      :select => "DISTINCT #{Doc.table_name}.*",
      :conditions => ["#{Title.table_name}.title LIKE ?", "%#{search}%"]}
  }

  named_scope :xtra_search, lambda { |search|
    {:joins => :xtras,
      :select => "DISTINCT #{Doc.table_name}.*",
      :conditions => ["#{Xtra.table_name}.term LIKE ?", "%#{search}%"]}
  }

  named_scope :approveddate_after, lambda {|date|
   {:conditions => ["#{Doc.table_name}.approveddate > ?", date]}
  }
  
  named_scope :approveddate_before, lambda {|date|
   {:conditions => ["#{Doc.table_name}.approveddate < ?", date]}
  }

  named_scope :birthdate_after, lambda {|date|
   {:conditions => ["#{Doc.table_name}.birthdate > ?", date]}
  }

  named_scope :birthdate_before, lambda {|date|
   {:conditions => ["#{Doc.table_name}.birthdate < ?", date]}
  }

  named_scope :modifieddate_after, lambda {|date|
   {:conditions => ["#{Doc.table_name}.modifieddate > ?", date]}
  }

  named_scope :modifieddate_before, lambda {|date|
   {:conditions => ["#{Doc.table_name}.modifieddate < ?", date]}
  }

  named_scope :expiredate_before, lambda { |date|
    {:joins => :expirations,
      :conditions => ["#{Expiration.table_name}.expiredate < ?", date]}
  }

  named_scope :expiredate_after, lambda { |date|
    {:joins => :expirations,
      :conditions => ["#{Expiration.table_name}.expiredate > ?", date]}
  }

  named_scope :importance_below, lambda { |rank|
    {:conditions => ["#{Doc.table_name}.importance < ?", rank]}
  }

  named_scope :importance_above, lambda { |rank|
    {:conditions => ["#{Doc.table_name}.importance > ?", rank]}
  }

  named_scope :status_below, lambda { |rank|
    {:conditions => ["#{Doc.table_name}.status < ?", rank]}
  }

  named_scope :status_above, lambda { |rank|
    {:conditions => ["#{Doc.table_name}.status > ?", rank]}
  }

  named_scope :visibility_below, lambda { |rank|
    {:conditions => ["#{Doc.table_name}.visibility < ?", rank]}
  }

  named_scope :visibility_above, lambda { |rank|
    {:conditions => ["#{Doc.table_name}.visibility > ?", rank]}
  }

  named_scope :volatility_below, lambda { |rank|
    {:conditions => ["#{Doc.table_name}.volatility < ?", rank]}
  }

  named_scope :volatility_above, lambda { |rank|
    {:conditions => ["#{Doc.table_name}.volatility > ?", rank]}
  }

  named_scope :include_default_title,
    :include => :default_title

  named_scope :include_visibility,
    :include => :visibility_assoc

  named_scope :include_volatility,
    :include => :volatility_assoc
  
  def docid
    id
  end
  # --- Permissions --- #

  def create_permitted?
    return true if acting_user.administrator?

    false
  end

  def update_permitted?
    return true if acting_user.administrator?

    false
  end

  def destroy_permitted?
    return true if acting_user.administrator?

    false
  end

  def view_permitted?(field)
    true
  end

end
