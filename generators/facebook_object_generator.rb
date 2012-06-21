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

    scraped_facebook_objects.each do |scraped_facebook_object|
      puts scraped_facebook_object
      add_object(scraped_facebook_object.split(':').first) if !!(scraped_facebook_object.match(/^\w+/))
    end
  end
  
  private

  def add_object object_name
    template_path = File.expand_path(File.join(File.dirname(__FILE__), "templates"))
    facebook_object_template = File.open("#{template_path}/fakebook_object.rb.erb")
    current_template =  ERB.new(facebook_object_template.read)
    facebook_object_template.close

    target_path = File.expand_path(
      File.join(File.dirname(__FILE__), "..", "lib", "fakebook-api", "facebook_collections", object_name.downcase + ".rb")
    )

    File.open(target_path, "w") { |f| f.write(current_template.result(binding)) } 
  end

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
end
