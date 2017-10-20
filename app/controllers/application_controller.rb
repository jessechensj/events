class ApplicationController < ActionController::Base
  before_action :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private

  def require_login
    unless current_user
      flash[:errors] = ["Please log in"]
      redirect_to '/users/new'
    end
  end
end
