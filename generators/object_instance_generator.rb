require 'json'
require 'faraday'

class FacebookObjectInstanceGenerator

  def initialize(facebook_object_name, sample_url) 
    @facebook_object_name = facebook_object_name
    @sample_url = sample_url
    begin
      @example = JSON.parse(sample_document)
    rescue 
      puts "Can not parse : " + facebook_object_name
    end
    write_template
  end

  def write_template
    template_path = File.expand_path(File.join(File.dirname(__FILE__), "templates"))
    facebook_object_template = File.open("#{template_path}/fakebook_object.rb.erb")
    current_template = ERB.new(facebook_object_template.read)
    File.open(path_for_class, "w") { |f| f.write(current_template.result(binding)) } 
  end

  private

  def path_for_class
    File.expand_path(
      File.join(File.dirname(__FILE__), 
                "..", 
                "lib", 
                "fakebook-api", 
                "facebook_collections", 
                @facebook_object_name.downcase + ".rb")
    )
  end
    
  def sample_document
    conn = Faraday.new(:url => @sample_url) do |faraday|
      faraday.request  :url_encoded
      #faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.get
    response.body
  end
end
