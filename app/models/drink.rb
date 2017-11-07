class Drink < ApplicationRecord
  belongs_to :user
  has_many :drink_ingredients, dependent: :destroy
  has_many :ingredients, through: :drink_ingredients

  validates :name, :instructions, presence: true
end
