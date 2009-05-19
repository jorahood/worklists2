class UsedBoilersController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def index
    hobo_index UsedBoiler.by_total_usages.apply_scopes(
      :order_by => parse_sort_param(:fromid, :boiler, :total_usages)),
      :paginate => false
  end

end
