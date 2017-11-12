class Drink < ApplicationRecord
  belongs_to :user
  has_many :drink_ingredients, dependent: :destroy
  has_many :ingredients, through: :drink_ingredients

  validates :name, :instructions, :drink_ingredients, presence: true

  accepts_nested_attributes_for :drink_ingredients

  scope :proper_cocktails, -> { joins(:ingredients).group("drinks.id").having("COUNT(drink_id) = 3") }
  
  def ingredients_attributes=(ingredients_attributes)
    ingredients_attributes.each do |key, value|
      next if value[:id].blank?
      
      ingredient = Ingredient.find_by(:id => value[:id])

      self.ingredients << ingredient

      dr_ing = self.drink_ingredients.last
      dr_ing.quantity = value[:quantity]
      dr_ing.save
      self.save
    end
  end

  def ingredients=(ingredients)
    #{"0"=>{"id"=>"5", "quantity"=>"2"}, "1"=>{"id"=>"7", "quantity"=>""}, "2"=>{"id"=>"3", "quantity"=>""}}
    
    # This is now a static array. We need this to keep track of the originial state of the drink
    # otherwise we'd modify the array as you iterate. Bad.
    original_ingredients = self.ingredients.to_ary

    ingredients.each do |ing_idx, ingredient_object|
      original_ing = original_ingredients[ing_idx.to_i]
      
      # If the user sets the selection field to '-', we will remove the ing
      # from the drink.
      if ingredient_object[:id] == ""
        self.ingredients.delete(original_ing)
        next
      end

      # We need to see if we need to update the ingredient, or just the quantity
      # If the original ingredient ID at the index in the hash matches the ID within
      # the hash at that index, they're the same and you just need to update quantity

      if original_ing.id == ingredient_object[:id].to_i
        dr_ing = DrinkIngredient.find_by(
          :drink_id => self.id, 
          :ingredient_id => original_ing.id
          )
        dr_ing.quantity = ingredient_object[:quantity]
        dr_ing.save
        next
      end

      # If the user has changed the original ingredient, we need to add it, 
      # delete the old one, and set the quantity
      
      self.ingredients.delete(original_ing)
      self.ingredients << Ingredient.find(ingredient_object[:id].to_i)
      dr_ing = DrinkIngredient.find_by(
        :drink_id => self.id, 
        :ingredient_id => ingredient_object[:id].to_i
        )
      dr_ing.quantity = ingredient_object[:quantity]
      dr_ing.save
      self.save
    end
  end
end