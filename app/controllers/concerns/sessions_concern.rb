module SessionsConcern
  extend ActiveSupport::Concern

  included do
    def current_user
      @current_user ||= current_session.try(:user)
    end

    def current_session
      @current_session ||= Session.find_by(token: cookies.signed[:session_id])
    end

    def logout
      current_session.update_attributes!(expired_at: Time.now) if current_session.present?
      cookies.delete(:session_id)
    end

    def session_token
      loop do
        token = SecureRandom.hex(APP_CONFIG['session_id_length'])
        return token unless Session.find_by(token: token, deleted_at: nil, expired_at: nil)
      end
    end
  end
end
