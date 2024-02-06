class ModifyAppointmentsForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :appointments, :patients
    add_foreign_key :appointments, :patients, on_delete: :cascade
  end
end
