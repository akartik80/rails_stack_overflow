module ApplicationConcern
  extend ActiveSupport::Concern
  include SessionsConcern

  def find_active(model, id = nil)
    active_records = model.active
    active_records = active_records.find_by(id: id) if id
    active_records
  end

  private

  def require_login
    # TODO: redirect to login page here if session is invalid
    render json: { error: 'Please login first' }, status: :unauthorized unless current_session
  end

  def require_logout
    render json: { error: 'Please logout first' }, status: :unauthorized if current_session
  end

  def check_current_user(user_id)
    render json: { error: 'Not Authorized' }, status: :unauthorized unless current_session.user_id == user_id
  end
end
