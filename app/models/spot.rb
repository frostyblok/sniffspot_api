class Spot < ApplicationRecord
  validates :title, :description, :price, presence: true
end
