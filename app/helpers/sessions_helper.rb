module SessionsHelper
  attr_writer :current_user

  def sign_in_user(user)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !current_user.nil?
  end
end
