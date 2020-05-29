class RepositoriesController < ApplicationController
  before_action :validate_params

  def index
    search = Repositories::SearchPerformer.new(index_search_params).call
    @formatted_response = search[:response]
    @error_message      = search[:error_message]
  end

  private

  def index_search_params
    @index_search_params ||= request.parameters
                                    .slice(:query, :sort, :order, :page)
                                    .symbolize_keys
  end

  # TODO: of course, the error message needs to be better formatted
  #       and also use I18n, not just 'as_json'
  def validate_params
    return(render(:index)) if index_search_params[:query].blank?

    validator = Repositories::ParamsValidator.call(index_search_params)
    return if validator.errors.blank?

    @error_message = validator.errors.as_json
    render :index
  end
end
