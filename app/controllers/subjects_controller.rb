# frozen_string_literal: true

class SubjectsController < ApplicationController
  def show
    subject

    if user_signed_in?
      @attempts = current_user.attempts.where(subject: subject).includes(answers: [:variant])
      if current_user.is_admin?
        @questions = subject.questions.includes(:variants)
        @members = []
        subject.attempts.group_by(&:user).each do |user, attempts|
          @members.push(
            {
              name: user.name,
              email: user.email,
              attempts_count: attempts.count,
              average_point: attempts.inject(0) { |sum, x| sum + (x.point || 0) } / attempts.size,
              best_point: attempts.map { |x| x.point || 0 }.max
            }
          )
        end
      end
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
