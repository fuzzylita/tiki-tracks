class DrinkIngredientSerializer < ActiveModel::Serializer
  attributes :id, :quantity

  attribute :name do
    object.ingredient.name
  end
end