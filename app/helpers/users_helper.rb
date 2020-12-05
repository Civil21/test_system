# frozen_string_literal: true

module UsersHelper
  def log_in(user)
    @current_session = Session.create user: user
    cookies.permanent[:session_token] = @current_session.token
    cookies.permanent[:user_id] = user.id
    self.current_user = user
    response.set_header 'Session-Token', current_session.token
    current_session
  end

  def current_user
    @current_user ||= current_session.user if current_session && !current_session.destroyed?
  end

  def current_admin
    @current_admin ||= current_user if current_user.is_admin?
  end

  def current_session
    # Session.destroy_expired # Можливо варто зробити по часу
    @current_session ||= Session.find_by_token(cookies[:session_token]) if cookies[:session_token]
  end

  def current_user=(user)
    @current_user = user
  end

  def user_signed_in?
    !current_user.nil?
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    current_session&.destroy
    cookies.permanent[:session_token] = nil
    session[:cart_id] = nil
    self.current_user = nil
  end
end
