class SearchesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @search = find_instance
    @result_docs =
      Doc.apply_scopes(
      :title_search => @search.title_search,
      :xtra_search => @search.xtra_search,
      :"approveddate_#{@search.approveddate_is}" => 
        !@search.approveddate_is.blank? && @search.approveddate ?
        @search.approveddate : nil,
      :"birthdate_#{@search.birthdate_is}" => 
        !@search.birthdate_is.blank? && @search.birthdate ?
        @search.birthdate : nil,
      :"expiredate_#{@search.expiredate_is}" => 
        !@search.expiredate_is.blank? && @search.expiredate ?
        @search.expiredate : nil,
      :"modifieddate_#{@search.modifieddate_is}" => 
        !@search.modifieddate_is.blank? && @search.modifieddate ?
        @search.modifieddate : nil,
      :visibility_is => @search.visibility,
      :volatility_is => @search.volatility,
      :status_is => @search.status,
      :author_is => @search.author,
      :owner_is => @search.owner,
      :with_resource => @search.resource,
      :with_referenced_boiler => @search.boiler,
      :with_hotitem => @search.hotitem,
      :importance_is => @search.importance,
      :with_domains => @search.domains,
      :order_by => parse_sort_param(:id, :default_title, :birthdate, :modifieddate, :approveddate),
      :with_default_title => true
    ).paginate(
      :page => params[:page])
  end
end
