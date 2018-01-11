require_relative '../crud_controller'

class Api::V1::QuestionsController < CRUDController
  skip_before_action :check_authentication, only: [:index, :show]
  before_action :validate_question, only: [:update, :destroy]
  before_action :validate_current_user, only: [:update, :destroy]

  def index
    render json: Question.all, status: :ok
  end

  def show
    question = Question.includes(:comments, answers: :comments).find(params[:id])

    return render json: { error: 'Question not found' }, status: :not_found unless question
    render json: question, status: :ok
  end

  def create
    question = Question.new(question_params)
    question.user = current_user

    p current_user

    # could be due to server error, but will mostly be due to invalid params
    return render json: question.errors, status: :bad_request unless question.save

    render json: question, status: :created
  end

  def update
    return render json: @question.errors, status: :bad_request unless @question.update_attributes(question_params)
    render json: @question, status: :ok
  end

  def destroy
    @question.destroy!

    return render json: @question.errors, status: :internal_server_error unless @question.save(validate: false)
    render json: @question, status: :ok
  end

  private

  # dry its call
  def question_params
    params.require(:question).permit(:text, :user_id)
  end

  def questions
    current_user.questions
  end

  def validate_current_user
    check_current_user(@question.user_id)
  end

  def validate_question
    @question = Question.find(params[:id])
    render json: { error: 'Question not found' }, status: :not_found unless @question
  end
end
