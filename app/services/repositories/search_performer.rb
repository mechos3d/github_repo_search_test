module Repositories
  class SearchPerformer
    def initialize(params)
      @params = params
    end

    def call
      if github_response.success?
        { response: Formatter.new(github_response).call }
      else
        ErrorNotifier.call(github_response)
        { error_message: ErrorMessageChooser.call(github_response) }
      end
    end

    private

    attr_reader :params

    def github_response
      @github_response ||= Github::Client::RepositoriesSearch.new(params).call
    end
  end
end
