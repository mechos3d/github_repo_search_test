module Repositories
  class ErrorMessageChooser
    def self.call(raw_response)
      case raw_response.status
      when 400, 422
        # NOTE: http-codes: 400 / 422 - means invalid incoming params.
        #       It's our application's fault if it's our job to validate
        #       incoming arguments before sending them to github
        'Invalid parameters (or you encountered a bug)'
      when 403
        # NOTE: 403 Forbidden - Github returns it in case the rate-limit is exceeded
        #                       or there's a problem with authentication.
        'Rate limit exceeded, try later'
      when 500..599
        # NOTE: In some cases it can be not the Github's fault, but problems with our network -
        #       then the request will just timeout, but I'll ignore this possibility for now.
        'Github server error'
      else
        "Something's wrong"
      end
    end
  end
end
