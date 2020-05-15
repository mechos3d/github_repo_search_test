# frozen_string_literal: true

module Github
  class Client
    class RepositoriesSearch
      URL = 'search/repositories'

      def initialize(query:, sort: 'stars', order: 'desc')
        @query = query
        @sort = sort
        @order = order
      end

      # TODO: Better to keep this authorization data in Github module itself,
      # not system-wide Settings. Nothing in 'lib' folder need to depend from the application itself.
      def call
        Faraday.get(url) do |req|
          req.headers['Authorization'] = "Basic #{Settings.github.client.authorization}"
        end
      end

      private

      attr_reader :query, :sort, :order

      def url
        query_sting = "?q=#{query}&sort=#{sort}&order=#{order}"
        File.join(Github::Client::BASE_URL, URL) + query_sting
      end
    end
  end
end
