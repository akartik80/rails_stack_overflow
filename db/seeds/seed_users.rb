module SeedUsers
  def self.seed
    users = [
      {
        name: 'Kartik',
        email: 'kartik.arora@1mg.com',
        password_digest: BCrypt::Password.create('123')
      },

      {
        name: 'Viren',
        email: 'viren.chugh@1mg.com',
        password_digest: BCrypt::Password.create('456'),
        deleted_at: Time.now
      },

      {
        name: 'Nipun',
        email: 'nipun.manocha@1mg.com'
      }
    ]

    User.create(users)
  end
end