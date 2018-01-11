require_relative '../crud_controller'

class Api::V1::AnswersController < CRUDController
  private

  def filtered_params
    params.require(:answer).permit(:text)
  end

  def read_model
    return Question.find(params[:question_id]).answers if params[:question_id]
    Answer.all
  end

  def create_model
    current_user.answers.where(question_id: params[:question_id])
  end

  def update_model
    current_user.answers.find(params[:id]) if params[:id]
  end
end
