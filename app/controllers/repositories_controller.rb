class RepositoriesController < ApplicationController
  # TODO: Make Ajax request to refresh list of repositories instead of rerendering the page
  def index
    process_repositories_query if params[:query]

    @repositories ||= []
    @error_message ||= nil
  end

  private

  def process_repositories_query
    response = Github::Client::RepositoriesSearch.new(query: params[:query]).call

    if response.success?
      @repositories = Repositories::Formatter.new.call(response)
    else
      # TODO: add more details about the error
      @error_message = 'Something went wrong'
    end
  end
end
