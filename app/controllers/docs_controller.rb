class DocsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  autocomplete :query_scope => :id_starts
  def index
    hobo_index Doc.apply_scopes(
      :order_by => parse_sort_param(:id, :birthdate, :modifieddate, :approveddate),
      :visibility_assoc_is => params[:visibility],
      :volatility_assoc_is => params[:volatility])
  end

  def show
    @doc = find_instance
    hobo_show do |format|
      format.xml do
        render :xml => @doc
      end
      format.html do
        #leave this here
      end
    end
  end
end
