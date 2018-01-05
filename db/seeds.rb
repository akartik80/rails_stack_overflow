# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'bcrypt'

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
    password: BCrypt::Password.create('456'),
    salt: SecureRandom.hex(20),
    deleted_at: Time.now
  },

  {
    name: 'Nipun',
    email: 'nipun.manocha@1mg.com',
    salt: SecureRandom.hex(20)
  }
]

questions = []

User.all.each_with_index do |user, index|
  questions << {
    user_id: user.id,
    text: "Question #{index} by #{user.id}"
  }
end

User.create(users)
Question.create(questions)
