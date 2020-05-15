class RepositoriesController < ApplicationController
  # TODO: Make Ajax request to refresh list of repositories.
  def index
    if params[:query]
      process_repositories_query
    else
      @repositories = []
    end
  end

  private

  def process_repositories_query
    res = Github::Client::RepositoriesSearch.new(query: params[:query]).call

    if res.success?
      @repositories = JSON.parse(res.body)['items'].map do |el|
        # TODO: move this to a presenter:
        el.slice('full_name', 'html_url', 'description')
      end
    else
      # TODO: add more details here of course:
      # TODO: return non-200 http code on non-successful github request
      flash.now[:alert] = "Something went wrong"
      @repositories = []
    end
  end
end
