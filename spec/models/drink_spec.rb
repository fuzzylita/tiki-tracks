require 'rails_helper'

RSpec.describe Drink, type: :model do

  context "Validations" do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:instructions)}
  end

  context "Relationships" do
    it { should belong_to(:user) }
    it { should have_many(:drink_ingredients).dependent(:destroy) }
  end
end