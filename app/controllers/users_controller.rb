class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[index show create]

  before_action :require_logout, only: :create
  before_action :validate_current_user, only: %i[update destroy]
  before_action :validate_user, only: %i[update destroy]

  def index
    render json: User.all, status: :ok
  end

  def show
    user = User.find_by(id: params[:id])

    return head :not_found unless user
    render json: user, status: :ok
  end

  def create
    user = User.new(user_create_params)

    return render json: user.errors, status: :bad_request unless user.save
    render json: user, status: :created
  end

  def update
    return render json: @user.errors, status: :bad_request unless @user.update_attributes(user_update_params)
    render json: @user, status: :ok
  end

  def destroy
    @user.deleted_at = Time.now

    return render json: @user.errors, status: :internal_server_error unless @user.save(validate: false)
    render json: @user, status: 200
    # @user.sessions.deleted_at = Time.now
    # @user.sessions.save!
  end

  private

  def user_update_params
    params.require(:user).permit(:name, :email)
  end

  def user_create_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def validate_user
    @user = User.find_by(id: params[:id])
    render json: { error: 'User not found' }, status: :not_found unless @user
  end

  def validate_current_user
    check_current_user(params[:id].to_i)
  end
end
