class CommentsController < ApplicationController
  def create
    user = User.active.find_by(id: comment_params[:user_id])
    return render json: { error: 'Invalid User' }, status: 404 unless user

    entity = comment_params[:entity_type].constantize.find_by(id: comment_params[:entity_id])
    return render json: { error: "Invalid #{comment_params[:entity_type]}" }, status: 404 unless entity

    @comment = Comment.new({
      text: comment_params[:text],
      commentable: entity,
      user: user
    })

    return render json: @comment.errors, status: 500 unless @comment.save
    render json: @comment, status: 201
  end

  def update
    user = User.active.find_by(id: comment_params[:user_id])
    return render json: { error: 'Invalid User' }, status: 404 unless user

    entity = comment_params[:entity_type].constantize.find_by(id: comment_params[:entity_id])
    return render json: { error: "Invalid #{comment_params[:entity_type]}" }, status: 404 unless entity

    @comment = Comment.find(params[:id])
    @comment.text = comment_params[:text]
    return render json: @comment.errors, status: 500 unless @comment.update_attributes({text: comment_params[:text]})
    render json: @comment, status: 200
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.deleted_at = Time.now
    return render json: @comment.errors, status: 500 unless @comment.save
    render json: @comment, status: 200
  end

  private

  # call once
  def comment_params
    #require all these
    comment_params = params.require(:comment).permit(:text, :entity_type, :entity_id)
    comment_params[:user_id] = cookies.signed[:user_id]
    comment_params
  end
end
