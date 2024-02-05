class CreateExerciseEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_entries do |t|
      t.string :goal
      t.integer :exercise_type
      t.integer :total_minutes
      t.date :date
      t.integer :mood_before
      t.integer :mood_after
      t.integer :stress_before
      t.integer :stress_after
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
