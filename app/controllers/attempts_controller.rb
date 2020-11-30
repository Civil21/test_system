# frozen_string_literal: true

class AttemptsController < ApplicationController
  def show
    @question = attempt.questions.find_by(params[:question_id]) unless params[:question_id].blank?
    @question ||= attempt.answers.where(variant_id: nil).first.question
  end

  def new
    # зробити реєстрацію користувачі якщо він ще не зареєстрований
  end

  def create
    attempt = Attempt.where(subject_id: params[:subject_id], user: current_user).last
    pp attempt.nil?
    pp attempt.status
    pp attempt.complete?

    attempt = attempt.create(subject_id: params[:subject_id], user: current_user) if attempt.nil? || attempt.complete?
    attempt.status = 0 if attempt.start_at.blank?
    if attempt.news?
      attempt.subject.questions.order('random()').limit(attempt.subject.questions_size).each do |question|
        answer = attempt.answers.build(question: question)
        answer.save
      end

      attempt.start_at = Time.now
      attempt.finish_at = Time.now + attempt.subject.time_size * 60 # час в хвилинах , вказує на закінчення тесту
      attempt.status = 'work'
    end
    if attempt.save
      redirect_to attempt_path attempt
    else
      flash_blok attempt.errors.full_messages
      flash_blok 'Помилка стоврення спроби тестування', 'error'
      redirect_back(fallback_location: subject_path(params[:subject_id]))
    end
  end

  def check_answer
    if attempt.work
      answer = attempt.answer(question_id: params[question_id])
      answer.update(variant_id: params[variant_id])
    else
      flash_blok 'тестування уже завершено', 'eror'
    end
    redirect_to attempt_path(attempt)
  end

  private

  def attempt
    @attempt ||= Attempt.find(params[:id])
    if @attempt.work?
      unless @attempt.time_left
        attempt.update(status: 3)
        flash_blok 'Тест завершено'
      end
    end
    @attempt
  end

  def attempt_params
    params.require(:attampt).permit(:subject)
  end
end
