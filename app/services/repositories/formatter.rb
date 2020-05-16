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
      parsed_body['items'].map do |el|
        el.slice('full_name', 'html_url', 'description').tap do |new_el|
          new_el['avatar_url'] = el['owner']['avatar_url']
        end
      end
    end

    attr_reader :raw_response
  end
end
