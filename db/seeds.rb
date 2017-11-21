# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.create(username: "Lita", email: "lita@lita.com", password: "password", password_confirmation: "password")

%w(gin rum whiskey bananas milk brandy vermouth beer).each do |ing|
  Ingredient.create(name: ing)
end

5.times do
  def random_name
    Faker::Dessert.flavor + " " + Faker::Hipster.word
  end

  d = User.first.drinks.create(
    name: random_name, 
    instructions: Faker::Hipster.sentence
  )

  ings = Ingredient.all.sample(3)
  ings.each do |ing|
    d.ingredients << ing
  end

  d.drink_ingredients.each do |di|
    di.quantity = Faker::Number.between(1,3)
    di.save
  end

  d.save
end