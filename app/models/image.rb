class Image < ApplicationRecord
  belongs_to :spot

  validates :url, presence: true
end
