require 'spec_helper'

describe FakebookAPI::Friends do
  subject { FakebookAPI::Friend }
  let(:graph) { Koala::Facebook::API.new(FakebookAPI.access_token) }
  let(:friends) { graph.get_connections("me", "friends") }
  
  before do 
    FakebookAPI.fake do
      friends
    end 
  end

  it { friends.count.should eql 5000 }
end
