class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      user.create_api_key
      render json: UserSerializer.new(user), status:201
    else
      render status: 404
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:id, :name, :email, :api_key)
  end
end