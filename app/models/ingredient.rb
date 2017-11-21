class Ingredient < ApplicationRecord
  has_many :drink_ingredients
  has_many :drinks, through: :drink_ingredients

  validates :name, presence: true

  def self.formatted_list
    @ingredients_list ||= all.collect {|x| [x.name, x.id]}
  end
end