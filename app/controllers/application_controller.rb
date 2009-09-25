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

  before_filter CASClient::Frameworks::Rails::Filter, :unless => :i_am_bdding_or_i_am_paprika

  protected

  def i_am_bdding_or_i_am_paprika
    ENV['RAILS_ENV'] == 'test' ||
      ENV['RAILS_ENV'] == 'cucumber' ||
      request.env['REMOTE_ADDR'] == '129.79.213.151'
  end
end
