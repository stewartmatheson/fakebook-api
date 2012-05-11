module FakebookAPI
  def self.fake &options
    options.call self
  end

  def method_missing
    raise "Object not found"
  end
end
