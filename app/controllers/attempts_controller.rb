# frozen_string_literal: true

class AttemptsController < ApplicationController
  def show
    @question = attempt.questions.sample
  end

  def new
    # зробити реєстрацію користувачі якщо він ще не зареєстрований
  end

  def create
    attempt = Attempt.new(subject_id: params[:subject_id])
    attempt.user = current_user
    attempt.subject.questions.order('random()').limit(attempt.subject.questions_size)

    attempt.start_at = Time.now
    attempt.finish_at = Time.now + attempt.subject.time_size * 60 # час в хвилинах , вказує на закінчення тесту
    if attempt.save
      redirect_to attempt_path attempt
    else
      flash_blok 'Помилка стоврення спроби тестування', 'error'
    end
  end

  private

  def attempt
    @attempt ||= Attempt.find(params[:id])
  end

  def attempt_params
    params.require(:attampt).permit(:subject)
  end
end
