require 'rails_helper'

RSpec.describe 'Reviews API' do
  let!(:spot) { create(:spot) }
  let!(:reviews) { create_list(:review, 20, spot_id: spot.id) }
  let(:spot_id) { spot.id }
  let(:id) { reviews.first.id }

  describe 'GET /spots/:spot_id/reviews' do
    before { get "/spots/#{spot_id}/reviews"}

    context 'when spot exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all spot reviews' do
        expect( JSON.parse(response.body).size).to eq(20)
      end
    end

    context 'when spot does not exist' do
      let(:spot_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Spot/)
      end
    end
  end

  describe 'GET /spots/:spot_id/reviews/:id' do
    before { get "/spots/#{spot_id}/reviews/#{id}", params: {}, headers: headers }

    context 'when spot review exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the review' do
        expect( JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'when spot review does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Review/)
      end
    end
  end

  # Test suite for PUT /spots/:spot_id/reviews
  describe 'POST /spots/:spot_id/reviews' do

    context 'when request attributes are valid' do
      before { post "/spots/#{spot_id}/reviews", params: { content: 'Visit Narnia', rating: 4 } }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/spots/#{spot_id}/reviews", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Content can't be blank, Rating can't be blank/)
      end
    end
  end

  describe 'PUT /spots/:spot_id/reviews/:id' do
    before { put "/spots/#{spot_id}/reviews/#{id}", params: { content: 'Mozart'} }

    context 'when review exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the review' do
        updated_review = Review.find(id)
        expect(updated_review.content).to match(/Mozart/)
      end
    end

    context 'when the review does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Review/)
      end
    end
  end

  # Test suite for DELETE /spots/:id
  describe 'DELETE /spots/:id' do
    before { delete "/spots/#{spot_id}/reviews/#{id}", params: {} }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
