class DrinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :user_id, :created_at

  # This custom attribute allows us to access the creator's username from wthin drink

  attribute :username do
    object.user.username
  end

  # same for username

  attribute :rating do
    object.ratings.average(:rating)
  end

  # we access quantity through drink_ing, but this sets the field in JSON to be
  # 'ingredients' that we can pull the quantity from. (drink ingredients has both ingredient)
  # data and quantity data

  has_many :drink_ingredients, key: "ingredients"
end
