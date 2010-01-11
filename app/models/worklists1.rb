class Worklists1 < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "worklists1_#{RAILS_ENV}".to_sym
end
