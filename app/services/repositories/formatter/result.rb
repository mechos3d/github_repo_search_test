module Repositories
  class Formatter
    class Result
      attr_reader :repositories, :total_count

      def initialize(attributes)
        attributes.each do |attr_name, attr_value|
          instance_variable_set("@#{attr_name}", attr_value)
        end
      end
    end
  end
end
