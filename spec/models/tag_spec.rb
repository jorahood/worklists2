require 'spec_helper'

describe Tag do
  it { should have_many :taggings }
  it { should have_many(:listed_docs).through(:taggings) }
end
