class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token # will remove this

  def index
    render json: Question.all, status: 200
  end

  def show
    render json: Question.find(params[:id]), status: 200
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
    @question = Question.find(params[:id])

    if @question.update_attributes(question_params)
      render json: @question, status: 200
    else
      render json: @question.errors, status: 500
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.deleted_at = Time.now

    if @question.save
      render json: @question, status: 200
    else
      render json: @question.errors, status: 500
    end
  end

  private

  def question_params
    params.require(:question).permit(:text, :user_id)
  end
end
