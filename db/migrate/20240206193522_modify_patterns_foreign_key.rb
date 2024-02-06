class ModifyPatternsForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :patterns, :patients
    add_foreign_key :patterns, :patients, on_delete: :cascade
  end
end
