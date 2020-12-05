# frozen_string_literal: true

module ApplicationHelper
  def current_flash
    @flash = session[:flash] || []
  end

  def flash_blok(text, type = 'success')
    session[:flash] = (current_flash << [type, text])
  end

  def get_flash
    if current_flash.count > 0
      current_flash.shift
    else
      false
    end
  end
end
