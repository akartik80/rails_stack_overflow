require_relative '../crud_controller'

class Api::V1::SessionsController < CRUDController
  skip_before_action :check_authentication

  def create
    p 'heree'
    @user = User.find(params[:user_id])
    p @user, 123
    return render json: { error: 'User not found' }, status: :not_found unless @user
    return render json: { error: 'Wrong password' }, status: :ok unless @user.authenticate(login_params[:password])

    cookies.signed[:session_id] = SecureRandom.hex(20)

    render json: Session.create!(user_id: @user.id, token: cookies.signed[:session_id]), status: :created
  end

  def login
    # redirect here with 302
    return render json: current_session, status: :ok if current_session
    create
  end

  def destroy
    return render json: { error: 'Error in logout' } unless logout?
    render json: { message: 'Successfully logged out' }
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end