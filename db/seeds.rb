# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative './seeds/seed_users.rb'
require_relative './seeds/seed_questions.rb'
require_relative './seeds/seed_answers.rb'
require_relative './seeds/seed_tags.rb'
require_relative './seeds/seed_votes_and_comments.rb'
require_relative './seeds/seed_questions_tags.rb'
require_relative './seeds/seed_sessions.rb'

SeedUsers.seed
SeedQuestions.seed
SeedAnswers.seed
SeedTags.seed
SeedVotesAndComments.seed
SeedQuestionsTags.seed
SeedSessions.seed
