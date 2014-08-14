module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def current_event_for_new_category=(event)
    @current_event_for_new_category = event
  end

  def store_current_event_for_new_category
    @store_current_event_for_new_category
  end

  # Before filters for controllers

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless signed_in? && current_user.admin?
  end

  def correct_user_or_admin    
    redirect_to root_url unless (signed_in? && current_user.admin?) or current_user?(User.find(params[:id]))
  end

  def redirect_root_if_signed_in
    redirect_to root_url if signed_in?
  end

  def can_edit_event?
    signed_in? and current_user.events.find_by(id: params[:id])
  end

  def can_edit_submission
    current_user.submissions.find_by(id: params[:id]) or current_user.admin?
  end

end
