class FrontController < ApplicationController

  hobo_controller

  def index; end

  #FIXME: this gives error Mysql::Error: Table 'worklist_dev.worklists1s' doesn't exist: SHOW FIELDS FROM `worklists1s`
  def summary
    if !current_user.administrator?
      redirect_to '/'
    end
  end

  def search
    if params[:query]
      site_search(params[:query])
    end
  end

end
