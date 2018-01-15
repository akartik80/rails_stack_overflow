require_relative '../crud_controller'

class Api::V1::UsersController < CrudController
  skip_before_action :check_authentication, only: %i[index show create]

  before_action :require_logout, only: :create

  def read_model
    User.all
  end

  def create_model
    User
  end

  def update_model
    current_user
  end

  private

  def filtered_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
