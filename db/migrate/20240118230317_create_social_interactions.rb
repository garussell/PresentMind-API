class CreateSocialInteractions < ActiveRecord::Migration[7.1]
  def change
    create_table :social_interactions do |t|
      t.string :event_name
      t.integer :activity_type
      t.integer :social_rating
      t.string :location
      t.integer :duration_in_minutes
      t.date :date
      t.boolean :alcohol_use
      t.boolean :drug_use
      t.integer :mood_before
      t.integer :mood_after
      t.integer :stress_before
      t.integer :stress_after
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
