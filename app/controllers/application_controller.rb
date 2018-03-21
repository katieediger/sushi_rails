class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def current_organization
    @current_organization = current_user.organization
  end

  helper_method :current_organization
  helper_method :current_user
end
