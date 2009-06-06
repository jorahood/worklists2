class SearchesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @search = find_instance
    @result_docs =
      Doc.apply_scopes(
      :visibility_is => @search.visibility,
      :volatility_is => @search.volatility,
      :status_is => @search.status,
      :author_is => @search.author,
      :owner_is => @search.owner,
      :importance_is => @search.importance,
      :with_domains => @search.domains,
      :order_by => parse_sort_param(:id)
    ).paginate(
      :page => params[:page])
  end
end
