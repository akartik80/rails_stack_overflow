require_relative '../crud_controller'

class Api::V1::QuestionsController < CRUDController
  skip_before_action :check_authentication, only: [:index, :show]

  def read_model
    return Question.includes(:comments, answers: :comments) if params[:id]
    return Question.find_by(user_id: params[:user_id]) if params[:user_id]
    Question.all
  end

  def update_model
    current_user.questions.find(params[:id]) if params[:id]
  end

  def create_model
    current_user.questions
  end

  private

  def filtered_params
    params.require(:question).permit(:text, :user_id)
  end
end
