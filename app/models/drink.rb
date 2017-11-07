class Drink < ApplicationRecord
  belongs_to :user
  has_many :drink_ingredients
  has_many :ingredients, through: :drink_ingredients

  validates :name, :instructions, presence: true
end
