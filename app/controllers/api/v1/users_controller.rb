class Api::V1::UsersController < ApplicationController
before_action :check_login, only: [:login]
before_action :check_credentials, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: {error: user.errors.full_messages}, status: 404
    end
  end
  
  def login
    user = User.find_by(params[:login])

    if user.authenticate(user_params[:password])
      render json: UserSerializer.new(user), status: 200
    else
      render json: ErrorSerializer.new("Log in Credential is Invalid"), status: 404
    end
  end
  
  private
  def check_login
    if user_params[:email] == nil || user_params[:password] == nil
      render json: ErrorSerializer.new("Credential are Incorrect"), status: 404
    end
  end

  def check_credentials
    if user_params[:email] == nil || user_params[:password] == nil || user_params[:password_confirmation] == nil
      render json: ErrorSerializer.new("Credentials are invalid"), status: 404
    end
  end

  def user_params
    params.permit(:email, :password, :password_confirmation).merge(api_key: SecureRandom.hex)
  end
end