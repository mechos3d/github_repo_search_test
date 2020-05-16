module Repositories
  class GithubFailedResponseProcessor
    attr_reader :frontend_error_message

    def initialize(raw_response)
      @raw_response = raw_response
    end

    def call
      case raw_response.status
      when 400, 422
        # NOTE: http-codes: 400 / 422 - means invalid incoming params.
        #       It's our application's fault if it's our job to validate
        #       incoming arguments before sending them to github
        @frontend_error_message = 'Invalid parameters (or you encountered a bug)'
      when 403
        # NOTE: 403 Forbidden - Github returns it in case the rate-limit is exceeded
        #                       or there's a problem with authentication.
        @frontend_error_message = 'Rate limit exceeded, try later'
      when 500..599
        # NOTE: In some cases it can be not the Github's fault, but problems with our network -
        #       then the request will just timeout, but I'll ignore this possibility for now.
        @frontend_error_message = 'Github server error'
        notify_trackers
      else
        @frontend_error_message = "Something's wrong"
        notify_trackers
      end
    end

    private

    attr_reader :raw_response

    def notify_trackers
      # NOTE: Notify somebody about the problem.
      # Either send to Sentry or write to logs or some other action -
      # depending on the real infrastructure of a project
    end
  end
end
