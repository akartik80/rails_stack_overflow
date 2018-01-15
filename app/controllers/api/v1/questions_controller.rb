class Api::V1::QuestionsController < CrudController
  # auth is not required for showing questions
  skip_before_action :check_authentication, only: [:index, :show]

  # defines model for current controller
  # @return [model] model for the current controller
  def model
    Question
  end

  # renders current user's questions if user_id is given, else calls super
  # @return [json] questions
  def index
    return render json: User.find(params[:user_id]).questions if params[:user_id]
    super
  end

  # @return [json] question id with comments and answers (including answers' comments also)
  def show
    render json: model.includes(:comments, answers: :comments).find(params[:id])
  end

  # TODO: update deletes records from questions_tags also, update deleted_at in that case
  # update question with its tag associations
  # @return [json] updated question
  def update
    current_question.update_attributes!(question_params_with_tag)
    render json: current_question, status: :ok
  end

  # create question with its tag associations
  # @return [json] created question
  def create
    render json: current_user.questions.create!(question_params_with_tag), status: :ok
  end

  # TODO: update deletes records from questions_tags also, update deleted_at in that case
  # create question with its tag associations
  # @return [json] created question
  def destroy
    current_question.destroy!
    render json: current_question, status: :ok
  end

  private

  # whitelist params
  # @return [hash] whitelisted params hash
  def filtered_params
    @filtered_params ||= params.require(:question).permit(:text, tags: [])
  end

  # @return [ActiveRecord] current user's question by id
  def current_question
    @current_question ||= current_user.questions.find(params[:id])
  end

  # overwrite tags in params with tags ActiveRecord array
  # @return [hash] question with ActiveRecord tags
  def question_params_with_tag
    filtered_params.merge(tags: Tag.where(id: filtered_params[:tags]))
  end
end
