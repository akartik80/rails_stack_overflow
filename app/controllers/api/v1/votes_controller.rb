class Api::V1::VotesController < CrudController
  def model
    Vote
  end

  def index
    return render json: Question.find(params[:question_id]).votes, status: :ok if params[:question_id]
    render json: Answer.find(params[:answer_id]).votes, status: :ok
  end

  def create
    return update if current_user.votes.find_by(votable: entity)
    render json: current_user.votes.where(votable: entity).create!(filtered_params), status: :created
  end

  def update
    render json: current_vote.tap { |vote| vote.update_attributes!(filtered_params) }, status: :ok
  end

  def destroy
    current_vote.destroy!
    render json: current_vote, status: :ok
  end

  private

  def entity
    @model ||= params[:question_id] ? Question : Answer
    @entity ||= @model.find(params[:question_id] || params[:answer_id])
  end

  def filtered_params
    params.require(:vote).permit(:vote_type)
  end

  def current_vote
    return @current_vote ||= current_user.votes.find(params[:id]) if params[:id]
    @current_vote ||= current_user.votes.find_by(votable: entity)
  end
end
