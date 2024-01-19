class CreateMindfulnessActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :mindfulness_activities do |t|
      t.string :activity
      t.integer :total_minutes
      t.string :notes
      t.date :date
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
