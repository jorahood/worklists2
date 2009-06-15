class SearchesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @search = find_instance
    @result_docs =
      Doc.apply_scopes(
      :title_search => @search.title_search,
      :birthdate_is => @search.birthdate,
      :expires_on => @search.expiredate,
#      :approveddate_is => @search.approveddate,
      :modifieddate_is => @search.modifieddate,
      :visibility_is => @search.visibility,
      :volatility_is => @search.volatility,
      :status_is => @search.status,
      :author_is => @search.author,
      :owner_is => @search.owner,
      :with_resource => @search.resource,
      :importance_is => @search.importance,
      :with_domains => @search.domains,
      :order_by => parse_sort_param(:id, :birthdate, :modifieddate, :approveddate)
    ).paginate(
      :page => params[:page])
  end
end
