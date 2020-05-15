module Repositories
  class Formatter
    def call(raw_response)
      JSON.parse(raw_response.body)['items'].map do |el|
        el.slice('full_name', 'html_url', 'description')
      end
    end
  end
end
