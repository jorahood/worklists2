# add a class method to all ActiveRecord models that by default says they should not be imported from bell,
# to be overridden in the models that do derive their data from bell tables

module ActiveRecord
  class Base
    def self.import_from_bell
      false
    end
  end
end