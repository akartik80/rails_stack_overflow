class SessionGenerator
  def self.generate
    loop do
      token = SecureRandom.hex(APP_CONFIG['session_id_length'])
      return token unless Session.find_by(token: token, deleted_at: nil, expired_at: nil)
    end
  end
end
