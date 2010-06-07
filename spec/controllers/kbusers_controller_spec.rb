require 'spec_helper'

describe KbusersController do
  it "should have an autocomplete route for username" do
    get :complete_username
  end
end