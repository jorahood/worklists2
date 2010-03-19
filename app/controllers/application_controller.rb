# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '71eb230d499a9149c495242efe663878'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  before_filter CASClient::Frameworks::Rails::Filter, :unless => :i_am_working_or_i_am_dolga
  before_filter :set_current_user_from_cas
  before_filter :clean_casticket_param

  protected

  def i_am_working
    ENV['RAILS_ENV'] != 'production'
  end

  def i_am_dolga
    request.env['REMOTE_ADDR'] == '10.79.213.197'
  end

  def i_am_working_or_i_am_dolga
    i_am_working || i_am_dolga
  end

  def get_cas_username
    i_am_working ? params[:cas_user] : session[:cas_user]
  end

  def clean_casticket_param
     redirect_to params if params.delete(:casticket)
  end

  def set_current_user_from_cas
#    debugger
    if my_user = Kbuser.find_by_username(get_cas_username)
      session[:user] = my_user.typed_id
    end
  end
end
