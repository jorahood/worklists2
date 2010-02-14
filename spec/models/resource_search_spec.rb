require 'spec_helper'

describe ResourceSearch do
  context "Associations" do
    it { should belong_to :search }
    it { should belong_to :resource }
  end
end
