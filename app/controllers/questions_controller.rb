class QuestionsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :validate_question, only: %i[update destroy]
  before_action :validate_current_user, only: %i[update destroy]

  def index
    render json: find_active(Question), status: :ok
  end

  def show
    question = find_active(Question).includes(:comments, answers: :comments).find_by(id: params[:id])

    return render json: { error: 'Question not found' }, status: :not_found unless question
    render json: question, status: :ok
  end

  def create
    question = Question.new(question_params)

    # could be due to server error, but will mostly be due to invalid params
    return render json: question.errors, status: :bad_request unless question.save

    render json: question, status: :created
  end

  def update
    # could be due to server error, but will mostly be due to invalid params
    return render json: @question.errors, status: :bad_request unless @question.update_attributes(question_params)

    render json: @question, status: :ok
  end

  def destroy
    @question.deleted_at = Time.now

    return render json: @question.errors, status: :internal_server_error unless @question.save(validate: false)
    render json: @question, status: :ok
  end

  private

  # dry its call
  def question_params
    question_params = params.require(:question).permit(:text, :user_id)
    question_params[:user_id] = current_session.user.id
    question_params
  end

  def validate_current_user
    check_current_user(@question.user_id)
  end

  def validate_question
    @question = find_active(Question, params[:id])
    render json: {error: 'Question not found'}, status: :not_found unless @question
  end
end
