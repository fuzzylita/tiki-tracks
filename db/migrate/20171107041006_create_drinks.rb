class CreateDrinks < ActiveRecord::Migration[5.1]
  def change
    create_table :drinks do |t|
      t.string :name
      t.text :instructions
      t.integer :user_id
      t.timestamps
    end
  end
end
