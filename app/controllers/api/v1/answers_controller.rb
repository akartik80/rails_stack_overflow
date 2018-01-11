require_relative '../crud_controller'

class Api::V1::AnswersController < CRUDController
  private

  def create_params
    params.require(:answer).permit(:text, :question_id)
  end

  def update_params
    params.require(:answer).permit(:text)
  end

  def answer
    answers.find(params[:id])
  end

  def answers
    current_user.answers
  end

  def questions
    current_user.questions
  end

  def question
    questions.find(params[:question_id])
  end

  def model
    Answer
  end
end
