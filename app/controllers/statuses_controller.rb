class StatusesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @status = find_instance # Hobo needs @status defined
    @paginated_docs = @status.docs.paginate(:page => params[:page])
  end

end
