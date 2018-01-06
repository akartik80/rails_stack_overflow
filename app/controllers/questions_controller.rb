class QuestionsController < ApplicationController
  #write attr_accessor
  #
  def index
    render json: Question.active, status: 200
  end

  def show
    render json: Question.active.includes(:answers).find(params[:id]), status: 200
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: 201
    else
      render json: @question.errors, status: 500
    end
  end

  def update
    @question = Question.active.find(params[:id])

    if @question.update_attributes(question_params)
      render json: @question, status: 200
    else
      render json: @question.errors, status: 500
    end
  end

  def destroy
    @question = Question.active.find(params[:id])
    @question.deleted_at = Time.now

    if @question.save
      render json: @question, status: 200
    else
      render json: @question.errors, status: 500
    end
  end

  private

  def question_params
    question_params = params.require(:question).permit(:text, :user_id)
    question_params[:user_id] = cookies.signed[:user_id]
    question_params
  end
end
