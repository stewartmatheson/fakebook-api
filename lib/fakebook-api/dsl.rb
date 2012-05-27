module FakebookAPI

  def self.fake &options
    FakebookAPI::ObjectDispatcher.instance_eval(&options)
  end 

end
