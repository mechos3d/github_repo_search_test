class RepositoriesController < ApplicationController
  def index
    process_repositories_query if params[:query]
  end

  private

  def process_repositories_query
    response = Github::Client::RepositoriesSearch.new(index_search_params).call

    if response.success?
      @formatted_response = Repositories::Formatter.new(response).call
    else
      fail_processor = Repositories::GithubFailedResponseProcessor.new(response)
      fail_processor.call
      @error_message = fail_processor.frontend_error_message
    end
  end

  def index_search_params
    params.permit!
          .slice(:query, :sort, :order, :page)
          .to_h
          .each_with_object({}) { |(k, v), memo| memo[k.to_sym] = v if v }
  end
end
