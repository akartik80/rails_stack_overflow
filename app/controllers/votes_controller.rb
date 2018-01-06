class VotesController < ApplicationController
  def create
    user = User.active.find_by(id: vote_params[:user_id])
    return render json: { error: 'Invalid User' }, status: 404 unless user

    entity = vote_params[:entity_type].constantize.find_by(id: vote_params[:entity_id])
    return render json: { error: "Invalid #{vote_params[:entity_type]}" }, status: 404 unless entity

    @vote = Vote.find_by(votable: entity, user: user)
    return render json: { error: 'Already registered same vote' }, status: :ok if @vote && @vote[:vote_type] == vote_params[:vote_type]

    if @vote
      @vote[:vote_type] = vote_params[:vote_type]
    else
      @vote = Vote.new({
         vote_type: vote_params[:vote_type],
         votable: entity,
         user: user
       })
    end

    return render json: @vote.errors, status: 500 unless @vote.save
    render json: @vote, status: :created
  end

  def destroy
    @vote = Vote.active.find_by(id: params[:id])
    return render json: @vote, status: 400 unless @vote

    @vote.deleted_at = Time.now
    return render json: @vote.errors, status: 500 unless @vote.save
    render json: @vote, status: 200
  end

  private

  # call once
  def vote_params
    #require all these
    vote_params = params.require(:vote).permit(:vote_type, :entity_type, :entity_id)
    vote_params[:user_id] = cookies.signed[:user_id]
    # puts vote_params
    vote_params
  end
end
