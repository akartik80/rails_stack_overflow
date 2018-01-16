class Api::V1::CommentsController < CrudController
  def index
    return render json: Question.find(params[:question_id]).comments, status: :ok if params[:question_id]
    render json: Answer.find(params[:answer_id]).comments, status: :ok
  end

  def create
    render json: current_user.comments.where(commentable: entity).create!(filtered_params), status: :created
  end

  def update
    render json: current_comment.tap { |comment| comment.update_attributes!(filtered_params) }, status: :ok
  end

  def destroy
    current_comment.destroy!
    render json: current_comment, status: :ok
  end

  private

  def model
    Comment
  end

  def entity
    @model ||= params[:question_id] ? Question : Answer
    @entity ||= @model.find(params[:question_id] || params[:answer_id])
  end

  def current_comment
    @current_comment ||= current_user.comments.find(params[:id])
  end

  def filtered_params
    params.require(:comment).permit(:text)
  end
end
