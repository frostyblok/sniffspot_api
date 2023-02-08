class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :update, :destroy]

  include Response
  include ExceptionHandler

  def index
    @spots = Spot.all
    json_response(@spots)
  end

  def create
    spot = Spot.create!(spot_params)
    json_response(spot, "201")
  end

  def show
    json_response(@spot)
  end

  def update
    @spot.update(spot_params)
    head :no_content
  end

  def destroy
    @spot.destroy
    head :no_content
  end

  private

  def spot_params
    params.permit(:title, :description, :price, :image_url)
  end

  def set_spot
    @spot = Spot.find(params[:id])
  end
end
