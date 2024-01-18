class CreateSocialInteractions < ActiveRecord::Migration[7.1]
  def change
    create_table :social_interactions do |t|
      t.string :activity_type
      t.integer :number_of_participants
      t.integer :enjoyment_scale
      t.string :location
      t.integer :duration_in_minutes
      t.date :date
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
