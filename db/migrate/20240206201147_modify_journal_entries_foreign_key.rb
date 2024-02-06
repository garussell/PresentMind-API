class ModifyJournalEntriesForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :journal_entries, :patients
    add_foreign_key :journal_entries, :patients, on_delete: :cascade
  end
end
