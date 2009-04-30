class VisibilitiesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @visibility = find_instance # Hobo needs @visibility defined
    @paginated_docs = @visibility.docs.paginate(:page => params[:page])
  end

end
