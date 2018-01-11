module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid do |exception|
      invalid_params(exception)
    end

    def record_not_found
      head :not_found
    end

    def invalid_params(exception)
      render json: exception, status: :bad_request
    end
  end
end
