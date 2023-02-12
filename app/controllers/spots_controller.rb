class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :update, :destroy]

  def index
    @spots = Spot.all
    json_response(@spots.as_json(include: [:reviews], methods: %i[list_images average_ratings]))
  end

  def create
    ActiveRecord::Base.transaction do
      spot = Spot.create!(spot_params)
      spot.add_images!(params[:images])

      json_response(spot.as_json(include: [:reviews], methods: %i[list_images average_ratings]), :created)
    end
  end

  def show
    json_response(@spots.as_json(include: [:reviews], methods: %i[list_images average_ratings]))
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
    params.permit(:title, :description, :price, :images)
  end

  def set_spot
    @spot = Spot.find(params[:id])
  end
end
