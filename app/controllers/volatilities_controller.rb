class VolatilitiesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @volatility = find_instance # Hobo needs @volatility defined
    @paginated_docs = @volatility.docs.paginate(:page => params[:page])
  end

end
