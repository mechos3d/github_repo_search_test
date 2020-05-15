# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Client::RepositoriesSearch do
  context 'when everything is OK' do
    context 'when default values are used' do
      let(:query)        { 'foo' }
      let(:expected_url) { 'https://api.github.com/search/repositories/?q=foo&sort=stars&order=desc' }

      # TODO: test that it really sets Authorization headers
      it do
        expect(Faraday).to receive(:get).with(expected_url)
        described_class.new(query: query).call
      end
    end
  end
end
