class ImportancesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @importance = find_instance # Hobo needs @importance defined
    @paginated_docs = @importance.docs.paginate(:page => params[:page])
  end

end
