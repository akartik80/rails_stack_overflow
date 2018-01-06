class UsersController < ApplicationController
  def index
    render json: User.active, status: 200
  end

  def show
    @user = User.active.find_by(id: params[:id])

    return render json: { error: 'User not found' }, status: 404 unless @user
    render json: @user, status: 200
  end

  def create
    @user = User.new(user_create_params)

    return render json: @user.errors, status: 500 unless @user.save
    render json: @user, status: 201
  end

  def update
    @user = User.active.find_by(id: params[:id])

    return render json: { error: 'User not found' }, status: 404 unless @user
    return render json: @user.errors, status: 500 unless @user.update_attributes(user_update_params)
    render json: @user, status: 200
  end

  def destroy
    @user = User.active.find_by(id: params[:id])

    return render json: { error: 'User not found' }, status: 404 unless @user

    @user[:deleted_at] = Time.now

    return render json: @user.errors, status: 500 unless @user.save(validate: false)
    render json: @user, status: 200
  end

  private

  def user_update_params
    params.require(:user).permit(:name, :email)
  end

  def user_create_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
