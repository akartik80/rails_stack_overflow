require_relative '../crud_controller'

class Api::V1::SessionsController < CrudController
  skip_before_action :check_authentication

  def create
    return render json: current_session, status: :ok if current_session
    render json: Session.create!(user: authenticated_user, token: signed_cookie), status: :created
  end

  def destroy
    logout
    head :ok
  end

  private

  def filtered_params
    params.require(:user).permit(:email, :password)
  end

  def authenticated_user
    user = User.find_by(email: filtered_params[:email])
    raise ActiveRecord::RecordNotFound unless user
    raise WrongPasswordError.new('Password is incorrect') unless user.authenticate(filtered_params[:password])
    return user
  end

  def signed_cookie
    cookies.signed[:session_id] = session_token
  end
end
