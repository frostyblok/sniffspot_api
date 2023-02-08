class ReviewsController < ApplicationController
  before_action :set_spot
  before_action :set_spot_reviews, only: [:show, :update, :destroy]

  def index
    json_response(@spot.reviews)
  end

  def show
    json_response(@review)
  end

  def create
    @spot.reviews.create!(review_params)
    json_response(@spot, "201")
  end

  def update
    @review.update(review_params)
    head :no_content
  end

  def destroy
    @review.destroy
    head :no_content
  end

  private

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

  def set_spot_reviews
    @review = @spot.reviews.find_by!(id: params[:id]) if @spot
  end

  def review_params
    params.permit(:content, :rating)
  end
end
