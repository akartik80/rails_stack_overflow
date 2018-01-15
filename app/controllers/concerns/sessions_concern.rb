module SessionsConcern
  extend ActiveSupport::Concern

  included do
    def current_user
      @current_user ||= current_session.try(:user)
    end

    def current_session
      @current_session ||= Session.find_by(token: cookies.signed[:session_id])
    end
  end
end
