# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'bcrypt'
require_relative './seed_modules/seed_users.rb'
require_relative './seed_modules/seed_questions.rb'

SeedUsers.seed
SeedQuestions.seed
