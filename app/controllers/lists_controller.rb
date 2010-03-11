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
      :status_is => params[:status])
    # check if we need to do special sorting on doc attr. parse_sort_param has
    # the nice property that it will set @sort_field and @sort_direction only if one of
    # the parameters passed as an argument was passed as the "sort" url param. Since
    # the Hobo auto scope :order_by can't handle sorting by the attributes of a belongs_to
    # association, handle it ourselves by applying our custom named scope
    # "sort_by_doc_attr" after the vanilla order_by clause checks if "workstate" was
    # the selected sort param
    @listed_docs = @listed_docs.sort_by_doc_attr(
      parse_sort_param('approveddate', 'birthdate', 'modifieddate'))
    @listed_doc_fields = @list.selected_columns.join(', ')
  end
end
