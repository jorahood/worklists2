class Kb3 < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :oracle_on_bell
end
