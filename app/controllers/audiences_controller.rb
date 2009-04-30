class AudiencesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @audience = find_instance # Hobo needs @audience defined
    @paginated_titles = @audience.titles.paginate(:page => params[:page])
  end

end
