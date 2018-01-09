module SeedAnswers
  def self.seed
    answers = []

    Question.all.each do |question|
      3.times do |index|
        answers << {
          question_id: question.id,
          user_id: index + 1,
          text: "Answer of question #{question.id} by #{index + 1}"
        }
      end
    end

    Answer.create(answers)
  end
end
