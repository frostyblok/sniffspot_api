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
end
