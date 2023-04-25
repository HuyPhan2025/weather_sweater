class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: ErrorSerializer.new.invalid_request, status: 404
    end
  end

  def login
   
  end
  
  private
  def user_params
    params.permit(:email, :password, :password_confirmation).merge(api_key: SecureRandom.hex)
  end
end