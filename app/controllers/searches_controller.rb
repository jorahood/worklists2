class SearchesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @search = find_instance
    @result_docs =
      Doc.apply_scopes(
      :title_search => @search.title_search,
      :xtra_search => @search.xtra_search,
      :"approveddate_#{@search.approveddate_is}" => @search.approveddate,
      :"birthdate_#{@search.birthdate_is}" => @search.birthdate,
      :"expiredate_#{@search.expiredate_is}" => @search.expiredate,
      :"modifieddate_#{@search.modifieddate_is}" => @search.modifieddate,
      :"visibility_#{@search.visibility_is}" => @search.visibility_id,
      :"volatility_#{@search.volatility_is}" => @search.volatility_id,
      :"status_#{@search.status_is}" => @search.status_id,
      :"importance_#{@search.importance_is}" => @search.importance_id,
      :author_is => @search.author,
      :owner_is => @search.owner,
      :with_resource => @search.resource,
      :with_referenced_boiler => @search.boiler,
      :with_hotitem => @search.hotitem,
      :with_domains => @search.domains,
      :order_by => parse_sort_param(:id, :default_title, :visibility_assoc, :volatility_assoc, :birthdate, :modifieddate, :approveddate),
      :include => :default_title,
      :include => :visibility_assoc,
      :include => :volatility_assoc
    ).paginate(
      :page => params[:page])
  end
end
