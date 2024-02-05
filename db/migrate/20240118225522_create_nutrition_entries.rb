class CreateNutritionEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :nutrition_entries do |t|
      t.string :food_item
      t.integer :calories
      t.integer :number_of_servings
      t.boolean :healthy
      t.integer :cups_of_water
      t.integer :fruits_and_veg_servings
      t.boolean :correct_portion
      t.integer :mood_before
      t.integer :mood_after
      t.integer :stress_before
      t.integer :stress_after
      t.date :date
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
