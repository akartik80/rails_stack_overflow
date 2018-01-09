class AnswersController < ApplicationController
  before_action :validate_answer, only: %i[update destroy]
  before_action :validate_current_user, only: %i[update destroy]
  before_action :validate_question, only: %i[create update]

  def create
    answer = Answer.new(answer_params)

    # could be due to server error, but will mostly be due to invalid params
    return render json: answer.errors, status: :bad_request unless answer.save!

    render json: answer, status: :created
  end

  def update
    # could be due to server error, but will mostly be due to invalid params
    return render json: @answer.errors, status: :bad_request unless @answer.update_attributes(answer_params)

    render json: @answer, status: :ok
  end

  def destroy
    @answer.deleted_at = Time.now

    return render json: @answer.errors, status: :internal_server_error unless @answer.save(validate: false)
    render json: @answer, status: :ok
  end

  private

  # dry its call
  def answer_params
    answer_params = params.require(:answer).permit(:text, :question_id)
    answer_params[:user_id] = current_session.user_id
    answer_params
  end

  def validate_answer
    @answer = Answer.find_by(id: params[:id])
    render json: { error: 'Answer not found' }, status: :not_found unless @answer
  end

  def validate_current_user
    check_current_user(@answer.user_id)
  end

  def validate_question
    render json: { error: 'Invalid question' } unless Question.find_by(id: answer_params[:question_id])
  end
end
