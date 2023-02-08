require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:spot) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:rating) }
end
