class CreatePatterns < ActiveRecord::Migration[7.1]
  def change
    create_table :patterns do |t|
      t.date :start_date
      t.date :end_date
      t.integer :average_mood
      t.integer :average_stress_level
      t.integer :average_sleep_quality
      t.integer :average_sleep_hours
      t.integer :average_stress_before_exercise
      t.integer :average_stress_after_exercise
      t.integer :average_mood_with_good_nutrition
      t.integer :average_mood_with_bad_nutrition
      t.integer :average_mood_before_journaling
      t.integer :average_mood_after_journaling
      t.integer :average_mood_before_mindfulness
      t.integer :average_mood_after_mindfulness
      t.integer :average_stress_before_mindfulness
      t.integer :average_stress_after_mindfulness
      t.integer :average_mood_before_social_event
      t.integer :average_mood_after_social_event
      t.integer :average_mood_before_meds
      t.integer :average_mood_after_meds
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
