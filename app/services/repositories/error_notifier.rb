module Repositories
  class ErrorNotifier
    NO_NOTIFY_STATUSES = [400, 422, 403].freeze
    private_constant :NO_NOTIFY_STATUSES

    def self.call(*attrs)
      new(attrs).call
    end

    def initialize(raw_response)
      @raw_response = raw_response
    end

    def call
      return if NO_NOTIFY_STATUSES.includes?(raw_response.status)

      notify_trackers
    end

    private

    attr_reader :raw_response

    def notify_trackers
      # NOTE: Notify somebody about the problem.
      # Either send to Sentry or write to logs or some other action -
      # depending on the real infrastructure of a project.
    end
  end
end
