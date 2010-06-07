class BoilersController < ApplicationController

  hobo_model_controller

  auto_actions :all

  autocomplete :limit => 20

  def show
    @boiler = find_instance # Hobo needs @boiler defined
    @paginated_appearances_in_unarchived_docs = @boiler.appearances.unarchived.paginate(:page => params[:page])
  end

  def index
    hobo_index Boiler.unarchived.apply_scopes(
      :order_by => parse_sort_param(:name, :docid),
      :search    => [params[:search], :name, :docid])
  end
end
