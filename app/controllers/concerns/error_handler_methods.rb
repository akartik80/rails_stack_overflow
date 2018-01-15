module ErrorHandlerMethods
  def record_not_found
    head :not_found
  end

  def invalid_params(exception)
    render json: exception, status: :bad_request
  end
end
