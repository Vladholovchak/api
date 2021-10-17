# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do

  describe 'GET /index' do
    it 'returns http success' do
      get '/articles'
      expect(response).to have_http_status(:success)
    end

    it 'paginates results' do
      _article1, article2, _article3 = create_list(:article, 3)
      get '/articles', params: { page: { number: 2, size: 1 } }
      expect(json_data.length).to eq(1)
      expect(json_data.first[:id]).to eq(article2.id.to_s)
    end

    it 'contains pagination links in the response' do
      create_list(:article, 3)
      get '/articles', params: { page: { number: 2, size: 1 } }
      expect(json[:links].length).to eq(5)
      expect(json[:links].keys).to contain_exactly(
        :first, :prev, :next, :last, :self
      )
    end
  end
end
