require 'webmock'
require 'faker'

module FakebookAPI
  class FacebookObject
    
    include WebMock::API

    def self.create(count)
      @@friend_count = count
      @@results_per_page = 50 
      
      (@@friend_count / results_per_page).each do |page_number|
        stub_request(http_method, url_matcher).to_return(return_body)
      end
    end

    private

    # lets stub out a generic friend list to start with and match everything
    def self.url_matcher
      /http:\/\/graph.facebook.com\/\d+\/friends?.+/
    end

    def self.http_method
     :get
    end

    def self.return_body
    end
  end
end
