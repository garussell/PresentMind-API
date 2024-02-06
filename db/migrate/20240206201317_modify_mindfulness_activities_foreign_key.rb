class ModifyMindfulnessActivitiesForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :mindfulness_activities, :patients
    add_foreign_key :mindfulness_activities, :patients, on_delete: :cascade
  end
end
