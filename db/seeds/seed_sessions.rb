module SeedSessions
  def self.seed
    sessions = []

    User.all.each do |user|
      sessions << {
        user_id: user.id,
        token: SecureRandom.hex(20)
      }
    end

    Session.create(sessions)
  end
end
