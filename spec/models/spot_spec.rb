require 'rails_helper'

RSpec.describe Spot, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }

  describe "#list_images" do
    it 'should list all images for a spot' do
      spot = create(:spot)
      images = create_list(:image, 4, spot_id: spot.id)

      expect(spot.list_images).to eq(images.pluck(:url))
    end
  end

  describe "#add_images" do
    it 'should add images for a spot' do
      spot = create(:spot)
      images = create_list(:image, 4).pluck(:url)

      expect { spot.add_images(images) }.to change { Image.count }.by(4)
    end
  end

  describe "#average_ratings" do
    it 'should list average ratings for a spot' do
      spot = create(:spot)
      create(:review, rating: 5, spot_id: spot.id)
      create(:review, rating: 3, spot_id: spot.id)
      create(:review, rating: 5, spot_id: spot.id)
      create(:review, rating: 4, spot_id: spot.id)
      create(:review, rating: 1, spot_id: spot.id)
      create(:review, rating: 2, spot_id: spot.id)

      expect(spot.average_ratings).to eq(3.4)
    end
  end
end
