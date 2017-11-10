class Drink < ApplicationRecord
  belongs_to :user
  has_many :drink_ingredients, dependent: :destroy
  has_many :ingredients, through: :drink_ingredients

  validates :name, :instructions, presence: true

  accepts_nested_attributes_for :ingredients

  # ****** BROKEN METHOD FOR CREATING INGREDIENTS*****
  # scope :proper_cocktail { count(:ingredients).}
  # def self.quantity_list
  #   Ingredient.all.map do |ing|
  #     DrinkIngredient.new(ingredient: ing)
  #   end
  # end

  def ingredients_attributes=(ingredients_attributes)
    ingredients_attributes.values.each do |attrs|
      next if invalid_ingredient_attrs?(attrs)
      ingredient = Ingredient.find(attrs[:id])
      self.drink_ingredients.build(ingredient_id: ingredient.id, quantity: attrs[:quantity])
    end
  end

  private

  def invalid_ingredient_attrs?(attrs)
    attrs[:id].nil? || attrs[:quantity].nil? || attrs[:id].blank? || attrs[:quantity].blank?
  end
end