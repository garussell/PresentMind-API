class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :email
      t.date :dob
      t.string :phone
      t.string :address
      t.string :emergency_contact_name
      t.string :emergency_contact_number
      t.references :therapist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
