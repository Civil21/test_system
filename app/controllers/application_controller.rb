# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # respond_to :html, :json

  include ApplicationHelper

  def authenticate_user!
    unless user_signed_in?
      flash_blok('Please log in.', 'error')
      redirect_to login_path
    end
  end
end
