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

    def generate_structure(*params)
      { "id" => params[0], "name" => params[1] } 
    end
  end
end
