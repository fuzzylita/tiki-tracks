class DrinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :user_id, :created_at

  attribute :username do
    object.user.username
  end

  attribute :rating do
    object.ratings.average(:rating)
  end

  has_many :drink_ingredients, key: "ingredients"
end
