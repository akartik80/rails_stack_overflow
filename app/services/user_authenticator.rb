class UserAuthenticator
  def initialize(user)
    self.user = user
  end

  def authenticated_user
    user_to_authenticate = User.find_by(email: user[:email])
    raise ActiveRecord::RecordNotFound unless user_to_authenticate
    raise WrongPasswordError.new('Password is incorrect') unless user_to_authenticate.authenticate(user[:password])
    return user_to_authenticate
  end

  def self.logout(current_session, cookies)
    current_session.update_attributes!(expired_at: Time.now) if current_session.present?
    cookies.delete(:session_id)
    return current_session
  end

  private

  attr_accessor :user
end
