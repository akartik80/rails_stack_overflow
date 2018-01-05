class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token # will remove this

  def index
    render json: User.all, status: 200
  end

  def show
    render json: User.find(params[:id]), status: 200
  end

  def create
    @user = User.new(user_params)
    @user.salt = SecureRandom.hex(20)

    if @user.save
      render json: @user, status: 201
    else
      render json: @user.errors, status: 500
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      render json: @user, status: 200
    else
      render json: @user.errors, status: 500
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.deleted_at = Time.now

    if @user.save
      render json: @user, status: 200
    else
      render json: @user.errors, status: 500
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
