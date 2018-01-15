class Api::V1::SessionsController < CrudController
  skip_before_action :check_authentication

  def create
    return render json: current_session, status: :ok if current_session
    user_authenticator = UserAuthenticator.new(filtered_params)

    render json: Session.create!(
      user: user_authenticator.authenticated_user,
      token: signed_cookie
    ), status: :created
  end

  def destroy
    render json: UserAuthenticator.logout(current_session, cookies), status: :ok
  end

  private

  def filtered_params
    params.require(:user).permit(:email, :password)
  end

  def signed_cookie
    cookies.signed[:session_id] = SessionGenerator.generate
  end
end
