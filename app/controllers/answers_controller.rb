class AnswersController < ApplicationController
  before_action :validate_answer, only: %i[update destroy]
  before_action :validate_current_user, only: %i[update destroy]

  def create
    answer = Answer.new(answer_params)

    # could be due to server error, but will mostly be due to invalid params
    return render json: answer.errors, status: :bad_request unless answer.save

    render json: answer, status: 201
  end

  def update
    # could be due to server error, but will mostly be due to invalid params
    return render json: @answer.errors, status: :bad_request unless @answer.update_attributes(answer_params)

    render json: @answer, status: :ok
  end

  def destroy
    @answer.deleted_at = Time.now

    return render json: @answer.errors, status: :internal_server_error unless @answer.save
    render json: @answer, status: 200
  end

  private

  # dry its call
  def answer_params
    answer_params = params.require(:answer).permit(:text, :user_id, :question_id)
    answer_params[:user_id] = cookies.signed[:user_id]
    answer_params
  end

  def validate_answer
    @answer = find_active(Answer, params[:id])
    render json: {error: 'Answer not found'}, status: :not_found unless @answer
  end

  def validate_current_user
    check_current_user(@answer.user_id)
  end
end
