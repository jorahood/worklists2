class DocsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def index
    hobo_index Doc.apply_scopes(
      :order_by => parse_sort_param(:id),
      :visibility_assoc_is => params[:visibility],
      :volatility_assoc_is => params[:volatility])
  end

end
