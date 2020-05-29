module Repositories
  class Formatter
    class Repository
      attr_reader :full_name, :html_url, :description, :avatar_url

      def initialize(attributes)
        attributes.each do |attr_name, attr_value|
          instance_variable_set("@#{attr_name}", attr_value)
        end
      end
    end
  end
end
