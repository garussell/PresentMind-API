class CreateSleepEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :sleep_entries do |t|
      t.integer :quality_rating
      t.integer :total_hours
      t.boolean :dream
      t.string :notes
      t.date :date
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
