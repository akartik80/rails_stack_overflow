# controller actions for User resource
module Api::V1
  class UsersController < CrudController
    # auth is not required for showing user profile and signup
    skip_before_action :check_authentication, only: %i[index show create]

    # logged in user can't sign up
    before_action :require_logout, only: :create

    # defines model for current controller
    # @return [model] model for the current controller
    def model
      User
    end

    # updates current user
    # @return [json] updated user
    def update
      current_user.update_attributes!(filtered_params)
      render json: current_user, status: :ok
    end

    # deletes current user
    # @return [json] deleted user
    def destroy
      current_user.destroy!
      render json: current_user, status: :ok
    end

    private

    # whitelist params
    # @return [hash] whitelisted params hash
    def filtered_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end