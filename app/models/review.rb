class Review < ApplicationRecord
  belongs_to :spot

  validates :content, :rating, presence: true
end
