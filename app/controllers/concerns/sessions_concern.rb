module SessionsConcern
  def current_session
    cookie_session_id = cookies.signed[:session_id]
    Session.find_by(token: cookie_session_id)
  end

  def logout?
    session = current_session

    if session
      session[:deleted_at] = Time.now
      return false unless session.save!
    end

    cookies.delete(:session_id)
    true
  end
end
