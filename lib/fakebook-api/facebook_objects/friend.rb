module FakebookAPI::FacebookObjects
  class Friend < FakebookAPI::FacebookObject
    def initialize(params)
      super(params)
    end

    private

    def http_method
      :get
    end

    def facebook_object
      :friends
    end

    def structure
      { "id" => "", "name" => "" }
    end
  end
end
