# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::GithubFailedResponseProcessor do
  let(:fail_processor) { described_class.new(raw_response) }
  let(:response_http_code) { raise 'Is to be defined in concrete contexts' }
  let(:raw_response) do
    double.tap { |response| allow(response).to receive(:status).and_return(response_http_code) }
  end

  context 'when upstream retured code 500' do
    let(:response_http_code) { 500 }

    it do
      expect(fail_processor).to receive(:notify_trackers)

      fail_processor.call
      expect(fail_processor.frontend_error_message).to eq('Github server error')
    end
  end

  context 'when upstream retured code 403' do
    let(:response_http_code) { 403 }

    it do
      expect(fail_processor).not_to receive(:notify_trackers)

      fail_processor.call
      expect(fail_processor.frontend_error_message).to eq('Rate limit exceeded, try later')
    end
  end
end
