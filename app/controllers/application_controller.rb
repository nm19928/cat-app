class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :current_user

  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout!
    current_user.try(:restart_token)
    session[:session_token] = nil
  end

  def require_user
    if current_user.nil?
      redirect_to sessions_url
    end
  end

end
