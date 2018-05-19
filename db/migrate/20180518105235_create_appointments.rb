class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.references  :doctor, index: true, foreign_key: true
      t.references  :patient, index: true, foreign_key: true
      t.string :disease

      t.timestamps
    end
  end
end
