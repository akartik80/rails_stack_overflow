class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception # will uncomment this after views are implemented
  include ApplicationConcern
  include SessionsConcern
  include ErrorHandlers

  def current_user
    @current_user ||= current_session.try(:user)
  end

  def current_session
    @current_session ||= Session.find_by(token: cookies.signed[:session_id])
  end

  def logout?
    if current_session.present?
      # add expired_at instead
      # use destroy
      current_session.update_attributes!(deleted_at: Time.now)
    end

    cookies.delete(:session_id)
    return true
  end

  before_action :check_authentication
end
