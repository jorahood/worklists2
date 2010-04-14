class ListsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  web_method :refresh_search do
    @list = find_instance
    @list.refresh_search
    redirect_to this
  end

  def show
    @list = find_instance
    @listed_docs =
      @list.listed_docs.apply_scopes(:search => [params[:search], :doc_id, :status, :tag],
      :order_by => parse_sort_param(:workstate),
      :status_is => params[:status],
      # check if we need to sort on doc attr. parse_sort_param will set @sort_field and @sort_direction iff the "sort"
      # url param matches one of the args. 
      :sort_by_doc_attr => parse_sort_param(:approveddate, :birthdate, :modifieddate))
    @listed_doc_fields = @list.selected_columns.join(', ')
  end
end
