class CreateTherapists < ActiveRecord::Migration[7.1]
  def change
    create_table :therapists do |t|
      t.string :name
      t.string :email
      t.string :office_number
      t.string :specialization
      t.integer :years_in_practice
      t.string :credentials
      t.string :bio

      t.timestamps
    end
  end
end
