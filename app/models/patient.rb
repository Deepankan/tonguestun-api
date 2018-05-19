class Patient < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments

  def self.get_lists
    self.all.map { |patient| { patient_id: patient.id, patient_name: patient.name } }
  end
end
