module FakebookAPI  
  class ObjectDispatcher
    def self.register_object path
      file_name = path.split('/').last
      object_name = classify(file_name[0..(file_name.length - 4)])

      meta_def object_name.downcase do |*params|
        eval("FakebookAPI::FakebookCollections::#{object_name}.new(params)")
      end
    end

    def self.classify(incoming)
      incoming[0].upcase << incoming[1..incoming.length]
    end

    private 

    #yep this needs to be fixed by I really don't want to include
    #active support.
    def self.pluralize(incoming)
      incoming << "s"
    end

    def self.meta_def name, &blk
      (class << self; self; end).instance_eval { define_method name, &blk }
    end
  end
end
