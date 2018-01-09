module SeedQuestions
  def self.seed
    questions = []

    User.all.each do |user|
      2.times do |index|
        questions << {
          user_id: user.id,
          text: "Question #{index + 1} by #{user.id}"
        }
      end
    end

    Question.create(questions)
  end
end
