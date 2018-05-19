class Doctor < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments


  def self.get_lists
    self.all.map { |doctor| { doctor_id: doctor.id, doctor_name: doctor.name } }
  end
end
