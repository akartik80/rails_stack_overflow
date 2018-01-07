class SessionsController < ApplicationController
  skip_before_action :require_login

  def create
    @user = find_active(User).find_by(email: login_params[:email])
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
    @session = current_session

    if @session
      @session[:deleted_at] = Time.now
      return render json: { error: 'Error in logout' } unless @session.save
    end

    cookies.delete(:user_id)
    cookies.delete(:session_id)
    render json: { message: 'Successfully logged out' }, status: 200
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
