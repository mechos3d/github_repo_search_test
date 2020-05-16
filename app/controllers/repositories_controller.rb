class RepositoriesController < ApplicationController
  def index
    return if params_validation.errors.present? || params[:query].blank?

    search = Repositories::SearchPerformer.new(index_search_params).call
    @formatted_response = search[:response]
    @error_message      = search[:error_message]
  end

  private

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
  end
end
