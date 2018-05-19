class RegistrationsController < ApplicationController
  before_action :restrict_access, except: [ :sign_in, :forgot_password, :sign_up ]

  # Objective: This is method for signup
  # URL: /api/sign-up => POST request
  # Input: ALL User information
  # Output: success or unsuccess message
  def sign_up
    if params[:email].present? and params[:password].present? and params[:confirm_password].present? and \
      params[:password] == params[:confirm_password]
      begin
        user = User.new(email: params[:email],password: params[:password], encrypted_password: BCrypt::Password.create(params[:password]))
        if user.save
          token = user.access_tokens.create
          @msg = { status: STATUS_SUCCESS, token: token.access_token, user: token.user.email,  message: SUCCESS_MESSAGE }
        else
        #error = get_error_message(user.errors.messages)
          temp_message = {}
          user.errors.messages.each { |h,v| temp_message[h] =  v[0] }
          @msg = { status: STATUS_ERROR, error_message: temp_message }
        end
      rescue Exception => e
        user.really_destroy! if user and (message = user.errors.full_messages if user.errors.full_messages.present?)
        token.destroy if token and (message = token.errors.full_messages if token.errors.full_messages.present?)
        message =  message.present? ?  message.join(",") : CREDENTIAL_ERROR_MSG
        @msg = { status: STATUS_ERROR, message: message }
      end
    else
      @msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG }
    end
    render json: @msg
  end

  # Objective: This is method for signin
  # URL: /sign-in => POST request
  # Input: email/user_name/mobile_no and password
  # Output: success or unsuccess message
  def sign_in
    if params[:password] and user = User.find_by_email(params[:email])
    #cipher = Gibberish::AES.new(user.security_token)
    if BCrypt::Password.new(user.encrypted_password) == params[:password]
      token = user.access_tokens.create
      user.save
      msg = { status: STATUS_SUCCESS, token: token.access_token, user: token.user.email, message: SUCCESS_MESSAGE }
      render json: msg
     else
      msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG }
      render json: msg
     end
    else
      msg = { status: STATUS_ERROR, message: CREDENTIAL_ERROR_MSG }
      render json: msg
    end
    #TODO
  end

  # Objective: This is method for signout
  # URL: /sign-out
  # Input: Token
  # Output: success or unsuccess message
  def sign_out
    token = AccessToken.find_by(access_token: @token)
    token.destroy unless token.nil?
    msg = { status: STATUS_SUCCESS, message: SUCCESS_MESSAGE }

    render json: msg
  end
end