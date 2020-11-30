# frozen_string_literal: true

class SubjectsController < ApplicationController
  def show
    subject

    if user_signed_in?
      @attempts = current_user.attempts.where(subject: subject)
      @questions = subject.questions if current_user.is_admin?
    end
  end

  def index
    @subjects = Subject.all
  end

  private

  def subject
    @subject ||= Subject.find(params[:id])
  end
end
