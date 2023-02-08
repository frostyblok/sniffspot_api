class Spot < ApplicationRecord
  has_many :reviews
  has_many :images

  validates :title, :description, :price, presence: true

  def list_images
    images.pluck(:url)
  end

  def add_images(image_urls)
    image_urls.each do |image_url|
      images.create!(url: image_url)
    end
  end

  def average_ratings
    ratings = reviews.pluck(:rating)
    total_rating = ratings.inject(0, :+)
    (total_rating.to_f / ratings.size).ceil(1)
  end
end
