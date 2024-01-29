class CreateMoods < ActiveRecord::Migration[7.1]
  def change
    create_table :moods do |t|
      t.integer :current_mood_scale
      t.integer :stress_level_scale
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
