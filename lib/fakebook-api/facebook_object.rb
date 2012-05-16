require 'webmock'
require 'faker'

module FakebookAPI
  class FacebookObject
    
    include WebMock::API

    def initialize(params)
      @count = 100
      @results_per_page = 50 

      stub_request(http_method, url_matcher).to_return(to_return)
    end

    private

    def url_matcher
      "https://graph.facebook.com/me/friends?access_token=#{FakebookAPI.access_token}"
    end

    def facebook_object 
      raise("Abstract")
    end

    def http_method
      raise("Abstract")
    end

    def to_return
      { :status => 200, :body => return_body, :headers => {} }
    end

    def return_body
      "foobar"
    end
    
  end
end
