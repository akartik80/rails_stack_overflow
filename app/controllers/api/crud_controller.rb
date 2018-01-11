class CRUDController < ApplicationController
  def index
    render json: read_model, status: :ok
  end

  def show
    render json: read_model.find(params[:id]), status: :ok
  end

  def create
    render json: create_model.create!(filtered_params), status: :created
  end

  def update
    update_model.update_attributes!(filtered_params)
    render json: update_model, status: :ok
  end

  def destroy
    update_model.destroy!
    head :ok
  end
end
