class BoilerUsagesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def index
    hobo_index BoilerUsage.unarchived.by_total_usages.in_unarchived_docs.apply_scopes(
      :order_by => parse_sort_param(:docid, :boiler, :total_usages)),
      :paginate => false
  end
end
