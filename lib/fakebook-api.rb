require 'fakebook-api/error/facebook_object_not_supported'
require 'fakebook-api/facebook_object'
require 'fakebook-api/object_dispatcher'
require 'fakebook-api/dsl'
require 'fakebook-api/dsl'

Dir[File.dirname(__FILE__) + '/fakebook-api/fakebook_fields/*'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/fakebook-api/facebook_objects/*'].each do |file| 
  require file 
  FakebookAPI::ObjectDispatcher.register_object file
end


module FakebookAPI
  def self.access_token 
    "1122334455667788990011223344556677889900"
  end
end
