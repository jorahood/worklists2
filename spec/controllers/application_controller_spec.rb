require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationController do

  context "when Worklists2 is in production" do
    before :all do
      ENV['RAILS_ENV'] = 'production'
    end

    after :all do
      ENV['RAILS_ENV'] = 'test'
    end

    it "should redirect unlogged-in users to CAS" do
      get :index
      response.should be_redirect
      response.redirect_url.should match Regexp.new("https://cas.iu.edu/cas/login\\?cassvc=ANY&casurl=")
    end

    it "should let Paprika bypass CAS" do
      request.env['REMOTE_ADDR'] = '129.79.213.151'
      get :index
      response.should_not be_redirect
    end
  end
end
