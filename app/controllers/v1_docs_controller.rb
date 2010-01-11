class V1DocsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def index
    hobo_index V1Doc.apply_scopes(
      :order_by => parse_sort_param(:DOCID, :TITLE),
      :search    => [params[:search], :docid, :title])
  end


end
