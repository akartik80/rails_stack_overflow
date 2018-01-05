module SeedUsers
  def self.seed
    users = [
      {
        name: 'Kartik',
        email: 'kartik.arora@1mg.com',
        password: BCrypt::Password.create('123'),
        salt: SecureRandom.hex(20)
      },

      {
        name: 'Viren',
        email: 'viren.chugh@1mg.com',
        deleted_at: Time.now
      },

      {
        name: 'Nipun',
        email: 'nipun.manocha@1mg.com',
        salt: SecureRandom.hex(20)
      }
    ]

    User.create(users)
  end
end