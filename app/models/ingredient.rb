class Ingredient < ApplicationRecord
  has_many :drink_ingredients
  has_many :drinks, through: :drink_ingredients

  validates :name, presence: true

end