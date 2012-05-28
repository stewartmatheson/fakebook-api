require 'faraday'
require 'scrapi'

class FacebookObjectGenerator

  def initialize
    #create a new connection to facebook and pull down the html
    facebook_api_documentation = connection.get '/docs/reference/api'

    #scrape the html for the object pages
    api_scraper.scrape facebook_api_documentation.body

    #write the templates
    File.open(file_name, 'w') {|f| f.write(template.result) }
  end
  
  private

  def connection
    Faraday.new(:url => 'http://developers.facebook.com') do |builder|
      builder.use Faraday::Response::Logger
      builder.use Faraday::Adapter::NetHttp
    end 
  end

  def file_name
    "blah.rb"
  end

  def templte
    ERB.new(File.open('templates/facebook_object.rb.erb'))
  end

  def api_scraper
    Scraper.define do
      process "#bodyText > ul.first"
      result :description, :url, :price, :image
    end
  end
  
end
