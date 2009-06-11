class SearchesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @search = find_instance
    @result_docs =
      Doc.apply_scopes(
      :birthdate_is => @search.birthdate,
      :approveddate_is => @search.approveddate,
      :modifieddate_is => @search.modifieddate,
      :visibility_is => @search.visibility,
      :volatility_is => @search.volatility,
      :status_is => @search.status,
      :author_is => @search.author,
      :owner_is => @search.owner,
      :importance_is => @search.importance,
      :with_domains => @search.domains,
      :order_by => parse_sort_param(:id, :birthdate, :modifieddate, :approveddate)
    ).paginate(
      :page => params[:page])
  end
end
