require 'faker'

module FakebookAPI
  module FakebookFields
    class Name 

      def generated_value
        Faker::Name.name
      end

    end
  end
end
