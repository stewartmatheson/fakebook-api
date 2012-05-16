require 'spec_helper'

describe FakebookAPI do
  let(:graph) { Koala::Facebook::API.new(FakebookAPI.access_token) }
  let(:friends) { graph.get_connections("me", "friends") }
  
  before do 
    FakebookAPI.fake do
      friends
    end 
  end

  before do
    friends.each do |friend|
      puts friend["name"]
    end
  end

  it { friends.count.should eql 100 }
  
end
