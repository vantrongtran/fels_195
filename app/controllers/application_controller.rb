class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "please_login"
      redirect_to root_path
    end
  end

  def correct_user
    unless @user.is_user? current_user
      flash[:danger] = t "access_denied"
      redirect_to root_path
    end
  end

end
