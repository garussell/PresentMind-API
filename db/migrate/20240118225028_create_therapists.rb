class CreateTherapists < ActiveRecord::Migration[7.1]
  def change
    create_table :therapists do |t|
      t.string :name
      t.string :specialization
      t.string :credentials
      t.string :bio

      t.timestamps
    end
  end
end
