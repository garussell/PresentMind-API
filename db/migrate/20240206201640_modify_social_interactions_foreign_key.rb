class ModifySocialInteractionsForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :social_interactions, :patients
    add_foreign_key :social_interactions, :patients, on_delete: :cascade
  end
end
