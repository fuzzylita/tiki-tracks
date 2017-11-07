require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  context "Relationships" do
    it { should have_many(:drink_ingredients) }
  end

end