class CreateSleepEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :sleep_entries do |t|
      t.time :bed_time
      t.integer :quality_rating
      t.integer :total_hours
      t.boolean :dream
      t.string :notes
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
