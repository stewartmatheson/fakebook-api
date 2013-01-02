require 'scrapi'
require 'mechanize'
require 'object_instance_generator'

class FacebookObjectGenerator

  def initialize(fb_email, fb_pass)
    @fb_email = fb_email
    @fb_pass = fb_pass

    #run the the scraper
    scraped_facebook_objects = facebook_object_scraper.scrape(document_body)

    #iterate the scraped objects
    scraped_facebook_objects.each do |scraped_facebook_object|

      #lets pick the url from the string as we will need to fetch the sample object
      sample_url = scraped_facebook_object.match(/https?:\/\/[\S]+/).to_s

      #now lets get the name
      object_name = scraped_facebook_object.split(':').first

      if(is_facebook_object(object_name))
        FacebookObjectInstanceGenerator.new(object_name, sample_url)
        puts "Cretaed facebook object : #{object_name}"
      else
        puts "Can't create a facebook object : #{object_name}"
      end
    end
  end
  
  private

  def facebook_object_scraper
    Scraper.define do
      array :facebook_objects
      process "div#bodyText.bodyText li", :facebook_objects => :text
      result :facebook_objects
    end
  end

  def is_facebook_object scraped_facebook_object
    !(scraped_facebook_object.match(/\W/))
  end

  def document_body
    facebook_login_page = "http://www.facebook.com/login.php?next=http%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Freference%2Fapi%2F"
    agent = Mechanize.new
    page = agent.get(facebook_login_page)
    login_form = page.form(:id => 'login_form')
    login_form.email = @fb_email
    login_form.pass = @fb_pass
    page = agent.submit(login_form)
    page.body
  end
end
