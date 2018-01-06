class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token # will remove this

  # TODO: redirect to login page here if session is invalid
  # @session = Session.find_by(token: session[:session_id])

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  #
  # def authorize
  #   redirect_to '/login' unless current_user
  # end
end
