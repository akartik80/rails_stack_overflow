module ErrorHandlers
  extend ActiveSupport::Concern
  include ErrorHandlerMethods

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, WrongPasswordError, with: :invalid_params

    # rescue_from ActiveRecord::RecordInvalid, WrongPasswordError do |exception|
    #   invalid_params(exception)
    # end
  end
end
