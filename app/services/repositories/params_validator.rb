module Repositories
  class ParamsValidator
    include ActiveModel::Validations

    MAX_QUERY_LENGTH = 100
    private_constant :MAX_QUERY_LENGTH

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      validate_query_presence
      validate_query_length
      # TODO: Other validations can be implemented here
      self
    end

    private

    attr_reader :params

    def validate_query_presence
      errors.add(:query, 'Query must be filled') if params[:query].blank?
    end

    def validate_query_length
      return unless params[:query] && params[:query].size > MAX_QUERY_LENGTH

      errors.add(:query, "Maximum query length limit is: #{MAX_QUERY_LENGTH}")
    end
  end
end
