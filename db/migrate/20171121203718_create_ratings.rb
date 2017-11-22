class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.integer :drink_id
      t.integer :user_id
    end
  end
end
