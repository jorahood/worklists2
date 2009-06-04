class KbusersController < ApplicationController

  hobo_model_controller

  auto_actions :all

  autocomplete :limit => 20, :query_scope => :username_starts

  def show
    #sort docs collections by size
    @kbuser = find_instance # Hobo needs @kbuser defined
    @owned = @kbuser.owned_docs
    @authored = @kbuser.authored_docs
    @resourced = @kbuser.resourced_docs
    @main_docs, @first_aside_docs, @second_aside_docs = 
    [@kbuser.owned_docs, @authored, @resourced].sort_by {|docs| docs.length}.reverse
    @paginated_docs = @main_docs.empty? ? @main_docs : @main_docs.paginate(:page => params[:page])
  end

end
