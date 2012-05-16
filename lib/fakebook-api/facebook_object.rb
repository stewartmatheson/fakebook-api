require 'webmock'
require 'faker'

module FakebookAPI
  class FacebookObject
    
    include WebMock::API

    def initialize(count)
      @count = count
      @results_per_page = 50 

      (@count / @results_per_page).each do |page_number|
        stub_request(http_method, url_matcher).to_return(return_body)
      end
    end

    private

    def url_matcher
      Regexp.new "/http:\/\/graph.facebook.com\/\d+\/#{facebook_object}?.+/"
    end

    def facebook_object
      self.class.to_s.downcase
    end

    def http_method
      raise("Abstract")
    end

    def return_body
      "Foobar"
    end
    
  end
end
