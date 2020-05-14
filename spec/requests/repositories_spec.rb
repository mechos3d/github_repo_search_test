# frozen_string_literal: true

require 'rails_helper'

describe 'Repositories', type: :request do
  describe 'GET /repositories/' do

    let(:params) { {} }
    let(:headers) { {} }

    it 'renders the page' do
      # get '/repositories', params: params, headers: headers
      get '/repositories'

      expect(response).to render_template(:index)
    end
  end
end
