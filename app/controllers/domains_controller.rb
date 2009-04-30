class DomainsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def show
    @domain = find_instance # Hobo needs @domain defined
    @paginated_docs = @domain.docs.paginate(:page => params[:page])
  end

end
