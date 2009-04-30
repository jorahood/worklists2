class KbusersController < ApplicationController

  hobo_model_controller

  auto_actions :all

#  def index
#    @kbusers_search_sort = Kbuser.apply_scopes(:search => [params[:search], :id],
#      :order_by => parse_sort_param(:id,:lastname, :firstname, :email, :status))
#  end
  def show
    #decide whether the owned_docs or authored_docs collection is the main on based on doc count
    @kbuser = find_instance # Hobo needs @kbuser defined
    @owned = @kbuser.owned_docs
    @authored = @kbuser.authored_docs
    @main_docs, @first_aside_docs = @authored.count > @owned.count ?
      [@authored, @owned] : [@owned, @authored]
    @paginated_docs = @main_docs.paginate(:page => params[:page])
  end

end
