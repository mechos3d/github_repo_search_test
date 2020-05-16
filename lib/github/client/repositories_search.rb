# frozen_string_literal: true

module Github
  class Client
    class RepositoriesSearch
      DEFAULT_PER_PAGE = 30
      URL = 'search/repositories'

      def initialize(query:, sort: nil, order: 'desc', page: 1)
        @query = query
        @sort  = sort
        @order = order
        @page  = page
      end

      def call
        # TODO: add explicit timeout values
        Faraday.get(url) do |req|
          req.headers['Authorization'] = "token #{Github::Client::AUTHORIZATION}"
        end
      end

      private

      attr_reader :query, :sort, :order, :page

      def url
        query_sting = "?q=#{query}&sort=#{sort}&order=#{order}&page=#{page}"
        File.join(Github::Client::BASE_URL, URL) + query_sting
      end
    end
  end
end
