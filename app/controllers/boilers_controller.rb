class BoilersController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @boiler = find_instance # Hobo needs @boiler defined
    @paginated_appearances_in_docs = @boiler.appearances_in_docs.paginate(:page => params[:page])
  end

end
