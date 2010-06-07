require 'spec_helper'

describe BoilersController do
  it "should have an autocomplete route for name" do
    get :complete_name
  end
end