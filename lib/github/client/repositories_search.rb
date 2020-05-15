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

      # q=#{query}&sort=stars&order=desc
      # url = "https://api.github.com/search/repositories?q=#{query}&sort=stars&order=desc"
      def call
        Faraday.get(url) do |req|
          req.headers['Authorization'] = "Basic #{Github::Client::CREDENTIALS}"
        end
      end

      private

      attr_reader :query, :sort, :order

      def url
        query_sting = "?q=#{query}&sort=#{sort}&order=#{order}"
        File.join(Github::Client::BASE_URL, URL, query_sting)
      end
    end
  end
end
