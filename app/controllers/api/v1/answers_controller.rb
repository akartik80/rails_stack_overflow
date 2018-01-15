class Api::V1::AnswersController < CrudController
  # @return answers by question id
  def index
    render json: Answer.where(question_id: params[:question_id])
  end

  def create
    render json: current_user.answers.where(question_id: params[:question_id]).create!(filtered_params), status: :created
  end

  def update
    render json: current_answer.tap { |answer| answer.update_attributes!(filtered_params) }, status: :ok
  end

  def destroy
    current_answer.destroy!
    render json: current_answer, status: :ok
  end

  def model
    Answer
  end

  private

  def current_answer
    @current_answer ||= current_user.answers.find(params[:id])
  end

  def filtered_params
    params.require(:answer).permit(:text)
  end
end
