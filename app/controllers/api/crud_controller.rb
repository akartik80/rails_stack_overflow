# Provides basic crud operations on resources

module Api
  class CrudController < ApplicationController
    # @return [json] all records of model
    def index
      render json: model.all, status: :ok
    end

    # @return [json] record in model by id
    def show
      render json: model.find(params[:id]), status: :ok
    end

    # @return [json] current created record in model
    def create
      render json: model.create!(filtered_params), status: :created
    end

    # @return [json] current updated record in model
    def update
      render json: current_entity.tap { |entity| entity.update_attributes!(filtered_params) }, status: :ok
    end

    # @return [json] current deleted record in model
    def destroy
      current_entity.destroy!
      render json: entity, status: :ok
    end

    private

    # @return [ActiveRecord] record from model by id
    def current_entity
      model.find(params[:id])
    end
  end
end
