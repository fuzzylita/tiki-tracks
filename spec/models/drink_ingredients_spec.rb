require 'rails_helper'

RSpec.describe DrinkIngredient, type: :model do

  context "Relationships" do
    it { should belong_to(:drink) }
    it { should belong_to(:ingredient) }
  end

end