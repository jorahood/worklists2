class UsedBoilersController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def index
    sorter = parse_sort_param(:fromid) || [:fromid, 'asc']
    hobo_index UsedBoiler.by_total_usages.apply_scopes(:order_by => sorter), :paginate => false
  end

end
