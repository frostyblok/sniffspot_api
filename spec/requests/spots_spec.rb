require 'rails_helper'

RSpec.describe 'Spots API', type: :request do
  let!(:spots) { create_list(:spot, 10) }
  let(:spot_id) { spots.first.id }

  describe 'GET /spots' do
    before { get '/spots' }

    it 'returns spots' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /spots/:id' do
    before { get "/spots/#{spot_id}" }

    context 'when the record exists' do
      it 'returns the spot' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(spot_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:spot_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Spot/)
      end
    end
  end

  describe 'POST /spots' do
    let(:valid_attributes) do
      { title: 'Learn Elm',
        description: 'This is a random description',
        price: 30.9, image_urls: %w[http://ward.net/lolita.boyle http://hauck.org/yessenia http://flatley.info/jann_casper http://jacobi.name/tyrone.parker] }
    end

    context 'when the request is valid' do
      before { post '/spots', params: valid_attributes }

      it 'creates a spot' do
        binding.pry
        expect(JSON.parse(response.body)['title']).to eq('Learn Elm')
        expect(JSON.parse(response.body)['list_images'].size).to eq(4)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil, description: 'Random', price: 40.0, image_urls: [] } }
      before { post '/spots', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /spots/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/spots/#{spot_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /spots/:id' do
    before { delete "/spots/#{spot_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
