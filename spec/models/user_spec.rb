require 'rails_helper'

RSpec.describe User, type: :model do

  context "Validations" do
    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:password)}
    it { should validate_uniqueness_of(:email).case_insensitive}
  end

  context "Relationships" do
    it { should have_many(:drinks).dependent(:destroy) }
  end
end