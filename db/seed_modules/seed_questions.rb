module SeedQuestions
  def self.seed
    questions = []

    User.all.each do |user|
      2.times do |question_index|
        questions << {
          user_id: user.id,
          text: "Question #{question_index} by #{user.id}"
        }
      end
    end

    Question.create(questions)
  end
end
