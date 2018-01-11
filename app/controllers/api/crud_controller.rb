class CRUDController < ApplicationController
  def index
    render json: model.where(user_id: params[:user_id]), status: :ok if params[:user_id]
    render json: model.all, status: :ok
  end

  def create
    render json: model.create!(create_params), status: :created
  end

  def update
    update!(update_params)
    render json: :self, status: :ok
  end

  def destroy
    destroy!
    head :ok
  end
end
