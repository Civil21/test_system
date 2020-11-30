# frozen_string_literal: true

class AttemptsController < ApplicationController
  def show
    answers = attempt.answers.where(variant_id: nil)
    if answers.count == 0
      attempt.update(status: 'complete', finish_at: Time.now)

    else
      @question = attempt.questions.find_by(params[:question_id]) unless params[:question_id].blank?
      @question ||= answers.where(variant_id: nil).first.question
    end
  end

  def new
    # зробити реєстрацію користувачі якщо він ще не зареєстрований
  end

  def create
    attempt = Attempt.where(subject_id: params[:subject_id], user: current_user).last
    attempt = Attempt.create(subject_id: params[:subject_id], user: current_user) if attempt.nil? || attempt.complete?
    attempt.status = 'news' if attempt.start_at.blank?
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
    if attempt.work?
      question = Variant.find(params[:variant_id]).question
      answer = attempt.answers.find_by(question_id: question.id)
      answer.update(variant_id: params[:variant_id])
    else
      flash_blok 'тестування уже завершено', 'eror'
    end
    redirect_to attempt_path(attempt)
  end

  private

  def attempt
    @attempt ||= Attempt.includes(:answers).find(params[:id])
    if @attempt.work?
      unless @attempt.time_left
        @attempt.update(status: 'complete')
        flash_blok 'Тест завершено'
      end
    end
    @attempt
  end

  def attempt_params
    params.require(:attampt).permit(:subject)
  end
end
