require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationController do

  #Delete this example and add some real ones
  it "should use ApplicationController" do
    controller.should be_an_instance_of(ApplicationController)
  end

  it "should redirect unlogged-in users to CAS" do
    get :index
    response.should be_redirect
    response.redirect_url.should match Regexp.new("https://cas.iu.edu/cas/login\\?cassvc=ANY&casurl=")
  end
end
