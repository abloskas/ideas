class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :is_logged_in

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def is_logged_in
    !current_user.nil?
  end

  def check_permission
    if current_user.id != params[:id].to_i
      flash[:errors] = ['You are not granted permission for that!']
      redirect_to "/users"
    end
  end

  def require_login
    unless is_logged_in
      flash[:error] = "You must login to view this content!"
      redirect_to "/users"
    end
  end
end