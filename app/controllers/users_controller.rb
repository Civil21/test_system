# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show import_file destroy]

  def show; end

  def import_file
    Question.import(params[:file])
    flash_blok 'Питання успішно імпортовані'
    redirect_to profile_path
  end

  def new_login
    if user_signed_in?
      redirect_back(fallback_location: root_path)
    else
      @user = User.new
    end
  end

  def login
    if user_signed_in?
      redirect_back(fallback_location: root_path)
    else
      @user = User.find_by_email(user_params[:email])
      if user&.authenticate(user_params[:password])
        log_in user
        user_params[:remember_me] == '1' ? remember(user) : forget(user)
        # render json: { user: user }
      else
        flash_blok 'Неправильний пароль або email', 'error'
        redirect_to login_path
      end
    end
  end

  def logout
    log_out
    flash_blok 'Ви вийшли з вашого аккаунту.'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :remember_me)
  end

  def user
    @user ||= current_user
  end
end
