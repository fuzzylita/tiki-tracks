class DrinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :user_id

  attribute :username do
    object.user.username
  end

  has_many :drink_ingredients, key: "ingredients"
end
