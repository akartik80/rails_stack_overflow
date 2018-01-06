class SessionsController < ApplicationController
  def create
    @user = User.active.find_by(email: login_params[:email])
    return render json: { error: 'User not found' }, status: 404 unless @user
    return render json: { error: 'Wrong password' }, status: 200 unless @user.authenticate(login_params[:password])

    cookies.signed[:user_id] = @user.id
    cookies.signed[:session_id] = SecureRandom.hex(20)

    render json: Session.create!(user_id: @user.id, token: cookies.signed[:session_id]), status: 201
  end

  def check_logged_in
    @session = Session.active.find_by(token: cookies.signed[:session_id])
  end

  def login
    # redirect here with 302
    return render json: @session, status: 302 if check_logged_in
    create
  end

  def destroy
    @session = Session.active.find_by(token: cookies[:session_id])

    if @session
      @session[:deleted_at] = Time.now
      return render json: { error: 'Error in logout' } unless @session.save
    end

    cookies.delete(:user_id)
    cookies.delete(:session_id)
    render json: { message: 'Successfully logged out' }, status: 200
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
