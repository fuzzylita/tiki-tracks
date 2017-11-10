class CreateDrinkIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :drink_ingredients do |t|
      t.integer :drink_id
      t.integer :ingredient_id
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
