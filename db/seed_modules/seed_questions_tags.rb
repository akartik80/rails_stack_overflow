module SeedQuestionsTags
  def self.seed
    Question.all.each do |question|
      question.tags = Tag.all
    end
  end
end
