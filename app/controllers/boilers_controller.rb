class BoilersController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @boiler = find_instance # Hobo needs @boiler defined
    @paginated_appearances_in_docs = @boiler.appearances_in_docs.paginate(:page => params[:page])
  end

  def index
    sorter = parse_sort_param(:name, :docid) || [:name,'asc']
    hobo_index Boiler.include_doc.apply_scopes(:order_by => sorter), :paginate => false
  end
end
