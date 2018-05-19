Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/sign-in' => 'registrations#sign_in'
  get '/sign-out' => 'registrations#sign_out'
  post '/sign-up' => 'registrations#sign_up'
  post 'create-doctor' => 'dashboards#create_doctor'
  post 'create-patient' => 'dashboards#create_patient'
  get 'get-patient-doctor' => 'dashboards#get_patient_doctor'
  get 'get-dashboards' => 'dashboards#get_dashboards'
  post 'create-appointment' => 'dashboards#create_appointment'
  get 'get-appointments' => 'dashboards#get_appointments'
end
