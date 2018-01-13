require_relative '../crud_controller'

class Api::V1::CommentsController < CRUDController
  def read_model
    return Question.find(params[:question_id]).comments if params[:question_id]
    return Answer.find(params[:answer_id]).comments if params[:answer_id]
    Comment.all
  end

  def create_model
    model = params[:question_id] ? Question : Answer
    entity = model.find(params[:question_id] || params[:answer_id])
    current_user.comments.where(commentable: entity)
  end

  def update_model
    current_user.comments.find(params[:id])
  end

  private

  def filtered_params
    params.require(:comment).permit(:text)
  end
end
