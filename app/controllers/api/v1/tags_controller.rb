class Api::V1::TagsController < CrudController
  skip_before_action :check_authentication, only: %i[index show]

  def read_model
    Tag.all
  end

  def create_model
    Tag
  end

  def update_model
    Tag.find(params[:id])
  end

  def filtered_params
    params.require(:tag).permit(:text, :description)
  end
end
