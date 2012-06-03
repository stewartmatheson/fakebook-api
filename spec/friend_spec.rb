require 'spec_helper'

describe FakebookAPI do
  let(:graph) { Koala::Facebook::API.new(FakebookAPI.access_token) }
  let(:friends) { graph.get_connections("me", "friends") }
  
  before do 
    FakebookAPI.fake do
      friends :count => 1000
    end 
  end

  it { friends.count.should eql 1000 }
end
