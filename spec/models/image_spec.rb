require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should belong_to(:spot) }
  it { should validate_presence_of(:url) }
end
