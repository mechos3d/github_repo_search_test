# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::ParamsValidator do
  let(:params) { raise 'To be defined in concrete contexts' }
  let(:validator) { described_class.call(params) }

  context 'when params are valid' do
    let(:params) { { query: 'foo' } }

    it { expect(validator.errors.empty?).to be true }
  end

  context 'when the query is too long' do
    let(:params) { { query: '123456789' } }

    it do
      stub_const('Repositories::ParamsValidator::MAX_QUERY_LENGTH', 5)

      expect(validator.errors.empty?).to be false
      expect(validator.errors.messages[:query].first).to(
        eq('Maximum query length limit is: 5')
      )
    end
  end
end
