require_relative '../crud_controller'

class Api::V1::VotesController < CRUDController
  def read_model
    return Question.find(params[:question_id]).votes if params[:question_id]
    return Answer.find(params[:answer_id]).votes if params[:answer_id]
    Vote.all
  end

  def create
    return update if update_model
    super
  end

  def update_model
    return current_user.votes.find(params[:id]) if params[:id] # for destroy
    current_user.votes.find_by(votable: entity)
  end

  def create_model
    current_user.votes.where(votable: entity)
  end

  private

  def entity
    @model ||= params[:question_id] ? Question : Answer
    @entity ||= @model.find(params[:question_id] || params[:answer_id])
  end

  def filtered_params
    params.require(:vote).permit(:vote_type)
  end
end
