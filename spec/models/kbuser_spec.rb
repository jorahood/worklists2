require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Kbuser do

  subject {Factory.create(:kbuser)}

  it "should have 'username' as pk" do
    Kbuser.primary_key.should == "username"
  end

  # Attributes
  it "should let you check if a user is an editor" do
    pending "need to import UserTypes" do
      should respond_to :is_kbeditor?
    end
  end

  # Associations
  it {should have_many :lists}
  it {should have_many :notes}
  # Validations
  it {should validate_presence_of :username}
  # the Factory.create in the subject block above is because there must be an existing saved record for the
  # validate_uniqueness_of macro to work against: http://timharvey.net/2009/09/29/rspec-cant-find-first-objectname/
  it {should validate_uniqueness_of :username}
end
