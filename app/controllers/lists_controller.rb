class ListsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  web_method :refresh_search

  def show
    @list = find_instance
    @listed_docs =
      @list.listed_docs.apply_scopes(:search => [params[:search], :doc_id, :status, :tag],
      :order_by => parse_sort_param(:doc, :status, :tag),
      :status_is => params[:status])
  end
end
