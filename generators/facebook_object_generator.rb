require 'scrapi'
require 'mechanize'

class FacebookObjectGenerator

  def initialize(fb_email, fb_pass)
    @fb_email = fb_email
    @fb_pass = fb_pass

    #get the body HTML of the facebook page that needs to be scraped
    body = facebook_documentation_body

    facebook_object_scraper = Scraper.define do
      array :objects
      process "#bodyText > ul.first", :objects => :text
      result :objects
    end

    scraped_facebook_objects = facebook_object_scraper.scrape(body)
    puts scraped_facebook_objects

    #write the templates
    #File.open(file_name, 'w') {|f| f.write(template.result) }
  end
  
  private

  def facebook_documentation_body
    agent = Mechanize.new 

    facebook_login_page = "http://www.facebook.com/login.php?next=http%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Freference%2Fapi%2F"
    page = agent.get(facebook_login_page)

    facebook_doc_page = page.form_with(:id => 'login_form') do |login_form|
      login_form.email = @fb_email
      login_form.pass = @fb_pass
    end.submit

    facebook_doc_page.body
  end

  def file_name
    "blah.rb"
  end

  def templte
    ERB.new(File.open('templates/facebook_object.rb.erb'))
  end

end
