# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::ErrorMessageChooser do
  subject { described_class.call(raw_response) }

  let(:response_http_code) { raise 'Is to be defined in concrete contexts' }
  let(:raw_response) do
    double.tap { |response| allow(response).to receive(:status).and_return(response_http_code) }
  end

  context 'when upstream retured code 500' do
    let(:response_http_code) { 500 }

    it { is_expected.to eq('Github server error') }
  end

  context 'when upstream retured code 403' do
    let(:response_http_code) { 403 }

    it { is_expected.to eq('Rate limit exceeded, try later') }
  end
end
