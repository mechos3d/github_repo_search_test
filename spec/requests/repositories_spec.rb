# frozen_string_literal: true

require 'rails_helper'

describe 'Repositories', type: :request do
  RSpec.shared_examples 'successfully_renders_the_page' do
    it 'renders the page' do
      get '/repositories', params: params, headers: headers

      expect(response).to render_template(:index)
    end
  end

  describe 'GET /repositories/' do
    context 'when params are empty' do
      let(:params)  { {} }
      let(:headers) { {} }

      it_behaves_like 'successfully_renders_the_page'
    end

    context 'when params are filled' do
      let(:params) do
        {
          query: 'foo',
          sort:  'forks',
          order: 'desc',
          page:  4
        }
      end
      let(:headers) { {} }

      before do
        github_api_item_json = '{ "full_name": "foo1", "html_url": "foo2", '\
                               '"description": "foo3", "owner": { "avatar_url": "https://foo4" } }'

        # Webmock:
        stub_request(:get,
                     'https://api.github.com/search/repositories?order=desc&page=4&q=foo&sort=forks')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'token foo:bar',
              'User-Agent' => 'Faraday v1.0.1'
            }
          )
          .to_return(status: 200,
                     body: %({"items": [#{github_api_item_json}], "total_count": 0}),
                     headers: {})
      end

      it_behaves_like 'successfully_renders_the_page'
    end
  end
end
