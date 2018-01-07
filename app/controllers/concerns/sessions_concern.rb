module SessionsConcern
  def current_session
    cookie_session_id = cookies.signed[:session_id]
    find_active(Session).find_by(token: cookie_session_id)
  end
end
