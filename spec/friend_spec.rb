require 'spec_helper'

describe FakebookAPI do
  let(:graph) { Koala::Facebook::API.new(FakebookAPI.access_token) }
  let(:friends) { graph.get_connections("me", "friends") }
  
  before do 
    FakebookAPI.fake do
      friends
    end 
  end

  it { friends.count.should eql 5000 }
end
