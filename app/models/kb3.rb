class Kb3 < ActiveRecord::Base
  # The reason for this class is to group together all the models whose data originates on bell. I needed an additional way of
  # grouping models from bell besides #import_from_bell method since adding the index_item model which I have to not auto-import
  # with the others since it takes about 15 minutes to copy over and recreate the indices. Until index_item I was using the
  # non-appearance of #import_from_bell in the backup.rake task to select which models I needed to backup
  self.abstract_class = true
end
