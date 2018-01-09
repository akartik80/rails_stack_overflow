class CommentsController < ApplicationController
  before_action :validate_comment, only: %i[update destroy]
  before_action :validate_current_user, only: %i[update destroy]
  before_action :find_entity, only: %i[create update]

  def create
    comment = Comment.new({
      text: comment_params[:text],
      commentable: @entity,
      user: current_session.user
    })

    # could be due to server error, but will mostly be due to invalid params
    return render json: comment.errors, status: :bad_request unless comment.save

    render json: comment, status: :created
  end

  def update
    @comment.text = comment_params[:text]

    # could be due to server error, but will mostly be due to invalid params
    return render json: @comment.errors, status: :bad_request unless @comment.update_attributes({ text: comment_params[:text] })

    render json: @comment, status: :ok
  end

  def destroy
    @comment.deleted_at = Time.now

    return render json: @comment.errors, status: :internal_server_error unless @comment.save(validate: false)
    render json: @comment, status: :ok
  end

  private

  # call once
  def comment_params
    #require all these
    comment_params = params.require(:comment).permit(:text, :entity_type, :entity_id)

    if @comment
      entity = @comment.commentable
      comment_params[:entity_id] = entity.id
      comment_params[:entity_type] = entity.class.to_s
    end

    comment_params[:user_id] = current_session[:user_id]
    comment_params
  end

  def validate_comment
    @comment = Comment.find_by(id: params[:id])
    render json: {error: 'Comment not found'}, status: :not_found unless @comment
  end

  def validate_current_user
    check_current_user(@comment.user_id)
  end

  def find_entity
    # TODO: This relies on user params. Correct this
    @entity = comment_params[:entity_type].constantize.find_by(id: comment_params[:entity_id])
    render json: { error: "Invalid #{comment_params[:entity_type]}" }, status: :not_found unless @entity
  end
end
