require 'spec_helper'

descrie FakebookAPI::Friend do
  subject { FakebookAPI::Friend }
  
  before do 
    FakebookAPI::Friend.count(5000)
  end

  it { should }
end
