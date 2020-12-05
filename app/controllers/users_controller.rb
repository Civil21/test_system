# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[new_login login]

  def show; end

  def invite
    if current_admin
      new_user = User.create(user_id: user.id, email: params[:email], password: '123456qr', password_confirmation: '123456qr')
      # надсилати запрошення?
      flash_blok "Користувач #{new_user.email} успішно запрошений. Пароль для першого входу 123456qr"
      redirect_to profile_path
    else
      flash_blok 'У вас недостатньо прав', 'warning'
      redirect_back(fallback_location: root_path)
    end
  end

  def change_password
    if user.authenticate(user_params[:password])
      current_user.update(password: user_params[:new_password], password_confirmation: user_params[:new_password_confirmation])
      flash_blok 'Пароль успішно оновлено'
      redirect_to profile_path
    else
      flash_blok 'Неправильний пароль', 'error'
      redirect_back(fallback_location: root_path)
    end
  end

  def import_file
    if current_admin
      Question.import(params[:file])
      flash_blok 'Питання успішно імпортовані'
      redirect_to profile_path
    else
      flash_blok 'У вас недостатньо прав', 'warning'
      redirect_back(fallback_location: root_path)
    end
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
        params[:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to profile_path
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
    params.require(:user).permit(:email, :password, :new_password, :new_password_confirmation)
  end

  def user
    @user ||= current_user
  end
end
