module Repositories
  class Formatter
    def initialize(raw_response)
      @raw_response = raw_response
    end

    def call
      {
        repositories: repositories,
        total_count:  parsed_body['total_count']
      }
    end

    private

    def parsed_body
      @parsed_body ||= JSON.parse(raw_response.body)
    end

    def repositories
      parsed_body['items'].map do |item|
        formatted_item = item.slice('full_name', 'html_url', 'description')
        formatted_item['avatar_url'] = item['owner']['avatar_url']
        formatted_item
      end
    end

    attr_reader :raw_response
  end
end
