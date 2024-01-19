class CreateJournalEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :journal_entries do |t|
      t.string :title
      t.string :content
      t.date :date
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
