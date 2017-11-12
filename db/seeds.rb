# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "Lita", email: "lita@lita.com", password: "password", password_confirmation: "password")

%w(gin rum whiskey bananas milk brandy tacos).each do |ing|
  Ingredient.create(name: ing)
end

5.times do
  def random_name
    ('a'..'f').to_a.shuffle.join
  end

  d = User.first.drinks.create(name: random_name, instructions: random_name)

  ings = Ingredient.all.sample(3)
  ings.each do |ing|
    d.ingredients << ing
  end

  d.ingredients.each do |i|
    i.drink_ingredients.each do |di|
      di.quantity = (1..3).to_a.sample
      di.save
    end
  end

  d.save
end