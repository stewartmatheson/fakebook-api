require 'scrapi'
require 'mechanize'

class FacebookObjectGenerator

  def initialize(fb_email, fb_pass)
    @fb_email = fb_email
    @fb_pass = fb_pass

    #get the body HTML of the facebook page that needs to be scraped
    body = facebook_documentation_body

    facebook_object_scraper = Scraper.define do
      array :facebook_objects
      process "div#bodyText.bodyText li", :facebook_objects => :text
      result :facebook_objects
    end

    scraped_facebook_objects = facebook_object_scraper.scrape(body)
    puts scraped_facebook_objects
  end
  
  private

  def facebook_documentation_body
    facebook_login_page = "http://www.facebook.com/login.php?next=http%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Freference%2Fapi%2F"
    agent = Mechanize.new
    page = agent.get(facebook_login_page)
    login_form = page.form(:id => 'login_form')
    login_form.email = @fb_email
    login_form.pass = @fb_pass
    page = agent.submit(login_form)
    page.body
  end

  def file_name
    "blah.rb"
  end

  def templte
    ERB.new(File.open('templates/facebook_object.rb.erb'))
  end

end
