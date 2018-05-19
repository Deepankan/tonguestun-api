class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  def self.get_lists
    self.all.order('created_at asc').map { |appointment| { doctor_name: appointment.doctor.name, patient_name: appointment.patient.name, disease: appointment.disease } }
  end
end
