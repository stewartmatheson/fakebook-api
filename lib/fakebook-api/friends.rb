require 'webmock'
require 'faker'

module FakebookAPI
  class Friends
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
      response = ""
      @@results_per_page.each do |result_counter|
        random_friend = { "name" => Faker::Name, "id" => rand(10000000).to_s }
        response << JSON.encode(random_friend) 
      end
      response
    end

  end
end
