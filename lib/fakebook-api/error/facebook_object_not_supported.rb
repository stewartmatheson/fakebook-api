module FakebookAPI
  module Error
    class FacebookObjectNotSupported < StandardError

      def initialize(object_not_found)
        @requested_object = object_not_found
      end

      def to_s
        "Requesting #{@requested_object} but it is not a registered facebook object."
      end
    end
  end
end
