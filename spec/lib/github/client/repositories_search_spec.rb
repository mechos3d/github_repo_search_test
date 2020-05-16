# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Client::RepositoriesSearch do
  context 'when everything is OK' do
    context 'when default values are used' do
      subject { described_class.new(query: query).call }

      let(:query)        { 'foo' }
      let(:expected_url) do
        'https://api.github.com/search/repositories?q=foo&sort=&order=desc&page=1'
      end

      it do
        expect(Faraday).to receive(:get).with(expected_url)
        subject
      end
    end

    context 'when all values are sent explicitely' do
      subject { described_class.new(query: query, sort: sort, order: order, page: page).call }

      let(:query) { 'foo' }
      let(:sort)  { 'bar' }
      let(:order) { 'xyz' }
      let(:page)  { 5 }
      let(:expected_url) do
        'https://api.github.com/search/repositories?q=foo&sort=bar&order=xyz&page=5'
      end

      it do
        expect(Faraday).to receive(:get).with(expected_url)
        subject
      end
    end
  end
end
