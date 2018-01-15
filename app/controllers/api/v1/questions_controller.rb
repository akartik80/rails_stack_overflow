require_relative '../crud_controller'

class Api::V1::QuestionsController < CrudController
  skip_before_action :check_authentication, only: [:index, :show]

  def read_model
    return Question.includes(:comments, answers: :comments) if params[:id]
    return Question.find_by(user_id: params[:user_id]) if params[:user_id]
    Question.all
  end

  # update deletes records from questions_tags also, update deleted_at in that case
  def update
    current_user.questions.find(params[:id]).update_attributes!(filtered_params.merge(tags: Tag.where(id: filtered_params[:tags])))
    render json: current_user.questions.find(params[:id]), status: :ok
    # render json: current_user.questions.create!(filtered_params.merge(tags: Tag.where(id: filtered_params[:tags]))), status: :ok
  end

  def create
    render json: current_user.questions.create!(filtered_params.merge(tags: Tag.where(id: filtered_params[:tags]))), status: :ok
  end

  private

  def filtered_params
    @filtered_params ||= params.require(:question).permit(:text, tags: [])
  end
end
