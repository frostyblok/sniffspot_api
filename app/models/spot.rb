class Spot < ApplicationRecord
  has_many :reviews

  validates :title, :description, :price, presence: true
end
