class CreateMedicationEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :medication_entries do |t|
      t.string :name
      t.string :purpose
      t.string :dose
      t.string :schedule
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
