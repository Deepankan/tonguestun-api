class DashboardsController < ApplicationController
  before_action :restrict_access

  # Objective: This is method for signout
  # URL: /create-doctor
  # Input: Token, name, phone number, specilization
  # Output: success or unsuccess message
  def create_doctor
    if params[:name].present? and params[:phone_number].present? and params[:specialization].present?
      begin
        @doctor = Doctor.create(params.permit(:name, :phone_number, :specialization))
        @msg = { status: STATUS_SUCCESS, message: SUCCESS_MESSAGE, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email, doctor_lists: Doctor.get_lists, patient_lists: Patient.get_lists, appointments: Appointment.get_lists }
      rescue Exception => e
        @msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
      end
    else
      @msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
    end
    render json: @msg
  end

  # Objective: This is method for signout
  # URL: /create-patient
  # Input: Token, name, phone number
  # Output: success or unsuccess message
  def create_patient
    if params[:name].present? and params[:phone_number].present?
      begin
        @patient = Patient.create(params.permit(:name, :phone_number))
        @msg = { status: STATUS_SUCCESS, message: SUCCESS_MESSAGE, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email, doctor_lists: Doctor.get_lists, patient_lists: Patient.get_lists, appointments: Appointment.get_lists }
      rescue Exception => e
        @msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
      end
    else
      @msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
    end
    render json: @msg
  end

  # Objective: This is method for signout
  # URL: /get-patient-doctor
  # Input: Token
  # Output: doctor_id, patient_id
  def get_patient_doctor
    begin
      doctor_lists = Doctor.all.map { |doctor| { doctor_id: doctor.id, doctor_name: doctor.name } }
      patient_lists = Patient.all.map { |patient| { patient_id: patient.id, patient_name: patient.name } }
      @msg = { status: STATUS_SUCCESS, doctor_lists: doctor_lists, patient_lists: patient_lists, message: SUCCESS_MESSAGE, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
    rescue Exception => e
      @msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
    end
    render json: @msg
  end

  # Objective: This is method for signout
  # URL: /create-appointment
  # Input: Token, doctor_id, patient_id, disease
  # Output: success or unsuccess message
  def create_appointment
    if params[:doctor_id].present? and params[:patient_id].present? and params[:disease].present?
      begin
        @appointment = Appointment.create(params.permit(:doctor_id, :patient_id, :disease))
        @msg = { status: STATUS_SUCCESS, message: SUCCESS_MESSAGE, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email, doctor_lists: Doctor.get_lists, patient_lists: Patient.get_lists, appointments: Appointment.get_lists }
      rescue Exception => e
        @msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
      end
    else
      @msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
    end
    render json: @msg
  end

  # Objective: This is method for signout
  # URL: /get-appointment
  # Input: Token
  # Output: list of all appointment
  def get_appointments
    begin
      @appointments = Appointment.all.order('created_at asc').map { |appointment| { doctor_name: appointment.doctor.name, patient_name: appointment.patient.name, disease: appointment.disease } }
      @msg = { status: STATUS_SUCCESS, appointments: @appointments, message: SUCCESS_MESSAGE, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
    rescue Exception => e
      @msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
    end
    render json: @msg
  end

  # Objective: This is method for signout
  # URL: /get-dashboards
  # Input: Token
  # Output: doctor_id, patient_id, list of all appointment
  def get_dashboards
    begin
      @msg = { status: STATUS_SUCCESS, doctor_lists: Doctor.get_lists, patient_lists: Patient.get_lists, appointments: Appointment.get_lists, message: SUCCESS_MESSAGE, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
    rescue Exception => e
      @msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG, token: request.headers[:Authorization].split("Token token=").last, user: current_user.email }
    end
    render json: @msg
  end
end