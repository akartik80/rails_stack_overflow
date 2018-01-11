require_relative '../crud_controller'

class Api::V1::VotesController < CRUDController
  before_action :validate_vote, only: :destroy
  before_action :validate_current_user, only: :destroy
  before_action :find_entity, only: :create

  def create
    vote = Vote.new(
        vote_type: vote_params[:vote_type],
        votable: @entity,
        user: current_session.user
    )

    # could be due to server error, but will mostly be due to invalid params
    return render json: vote.errors, status: :bad_request unless vote.save

    render json: vote, status: :created
  end

  def destroy
    @vote.deleted_at = Time.now

    return render json: @vote.errors, status: :internal_server_error unless @vote.save(validate: false)
    render json: @vote, status: :ok
  end

  private

  # call once
  def vote_params
    #require all these
    params.require(:vote).permit(:vote_type, :entity_type, :entity_id)
  end

  def validate_vote
    @vote = Vote.find(params[:id])
    render json: { error: 'Vote not found' }, status: :not_found unless @vote
  end

  def validate_current_user
    check_current_user(@vote.user_id)
  end

  def votes
    current_user.votes
  end

  def find_entity
    # TODO: This relies on user params. Correct this
    @entity = vote_params[:entity_type].constantize.find(vote_params[:entity_id])
    render json: { error: "Invalid #{vote_params[:entity_type]}" }, status: :not_found unless @entity
  end
end
