class RepositoriesController < ApplicationController
  def index
    return unless params_validation.errors.empty?

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
    @index_search_params ||= begin
      params.permit!
            .slice(:query, :sort, :order, :page)
            .to_h
            .each_with_object({}) { |(k, v), memo| memo[k.to_sym] = v if v }
    end
  end

  def params_validation
    Repositories::ParamsValidator.call(index_search_params).tap do |x|
      # TODO: of course, the error message needs to be better formatted
      #       and also use I18n, not just 'as_json'
      @error_message = x.errors.as_json unless x.errors.empty?
    end
    # NOTE: maybe better to make it a 'before_action', fill 'errors' flash-message here
    # and perform a redirect ?
  end
end
