class RepositoriesController < ApplicationController
  def index
    process_repositories_query if params[:query]
    @error_message ||= nil
  end

  private

  def process_repositories_query
    response = Github::Client::RepositoriesSearch.new(index_search_params).call

    if response.success?
      @formatted_response = Repositories::Formatter.new(response).call
    else
      # TODO: add more details about the error
      @error_message = 'Something went wrong'
    end
  end

  def index_search_params
    params.permit!
          .slice(:query, :sort, :order, :page)
          .to_h
          .each_with_object({}) { |(k,v), memo| memo[k.to_sym] = v if v }
  end
end
