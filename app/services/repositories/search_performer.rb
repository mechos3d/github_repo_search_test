module Repositories
  class SearchPerformer
    def initialize(params)
      @params = params
    end

    def call
      if github_response.success?
        { response: Formatter.new(github_response).call }
      else
        fail_processor = GithubFailedResponseProcessor.new(github_response).tap(&:call)
        { error_message: fail_processor.frontend_error_message }
      end
    end

    private

    attr_reader :params

    def github_response
      @github_response ||= Github::Client::RepositoriesSearch.new(params).call
    end
  end
end
